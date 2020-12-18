module Clock
(
    input clk,
    input rst,
    input clk2,
    input [1:0]setLH,
    input [3:0]setRH,
    input [2:0]setLM,
    input [3:0]setRM,
    input setSignal,
    input alarmSignal,
    input almON,
    output reg[3:0] rightSec_cs,
    output reg[2:0] leftSec_cs,
    output reg[3:0] rightMin_cs,
    output reg[2:0] leftMin_cs,
    output reg[3:0] rightHr_cs,
    output reg[1:0] leftHr_cs,
    output reg alarmClk,
    output reg[1:0] AleftHr_o,
    output reg[3:0] ArightHr_o,
    output reg[2:0] AleftMin_o,
    output reg[3:0] ArightMin_o
);

    // Registers for right and left second digits
    reg sigMin;
    reg[3:0] rightSec_ns;
    reg[2:0] leftSec_ns;

    //Registers for right and left minute digits
    reg sigTwoFour;
    reg sigHr;
    reg[3:0] rightMin_ns;
    reg[2:0] leftMin_ns;

    // Registers for right anf left hour digits
    reg[3:0] rightHr_ns;
    reg[1:0] leftHr_ns;

    // Registers for hour and minute digits of alarm 
    reg[1:0] ALeftHr;
    reg[3:0] ARightHr;
    reg[2:0] ALeftMin;
    reg[3:0] ARightMin;

    // Registers for counter of alarm ON/OFF time
    reg[31:0] counter;
    reg[31:0] counter_next;

    //Set all regs on rst input
    always @(posedge clk)
    begin
        if(rst) begin
            rightSec_cs <= 4'b0001;
            rightSec_ns <= 4'b0000;
            leftSec_cs <= 3'b000;
            leftSec_ns <= 3'b000;
            sigMin <= 1'b0;
            rightMin_cs <= 4'b0000;
            rightMin_ns <= 4'b0000;
            leftMin_cs <= 3'b000;
            leftMin_ns <= 3'b000;
            sigHr <= 1'b0;
            rightHr_cs <= 4'b0000;
            rightHr_ns <= 4'b0000;
            leftHr_cs <= 2'b00;
            leftHr_ns <= 2'b00;
            sigTwoFour <= 1'b0;

            counter <= 32'd0;
            counter_next <= 32'd0;

            alarmClk <= 1'b0;
        end else begin // Set of current states
            rightSec_cs <= rightSec_ns;
            leftSec_cs <= leftSec_ns;
            rightMin_cs <= rightMin_ns;
            leftMin_cs <= leftMin_ns;
            rightHr_cs <= rightHr_ns;
            leftHr_cs <= leftHr_ns;
        end
    end

    //Second clock for setting digit states when setting clock time
    always @(posedge clk2)
    begin
        if(setSignal) begin
            if(alarmSignal == 0) begin
                leftHr_ns <= setLH;
                if(setLH == 2) begin
                    sigTwoFour = 1'b1;
                end
                rightHr_ns <= setRH;
                leftMin_ns <= setLM;
                rightMin_ns <= setRM;
            end 
        end else begin
            if(alarmSignal) begin
                ALeftHr <= setLH;
                ARightHr <= setRH;
                ALeftMin <= setLM;
                ARightMin <= setRM;
                AleftHr_o <= ALeftHr;
                ArightHr_o <= ARightHr;
                AleftMin_o <= ALeftMin;
                ArightMin_o <= ARightMin;
            end
        end
    end

    //If alarm states match current states then activate alarm
    always @(*) begin
        if(almON) begin
            if(leftHr_cs == ALeftHr) begin
                if(rightHr_cs == ARightHr) begin
                    if(leftMin_cs == ALeftMin) begin
                        if(rightMin_cs == ARightMin)
                            alarmClk <= 1'b1;
                    end
                end
            end
        end else begin
            alarmClk <= 1'b0;
            counter <= 32'd10;
        end
    end

    //Set next state of counter -> counter_next
    always @(posedge clk) begin
        counter <= counter_next;    
    end

    // If alarm is active add 1 to counter until it reaches 10 seconds
    always @(*) begin
        if(alarmClk) begin
            counter_next = counter + 1;
        end
        if(counter == 32'd300) //If counter reaches aprox 10 seconds alarm is turned off
            alarmClk = 1'b0;
            counter = 32'd0;
    end
    // Set next state for right second digit
    always @(*)
    begin
        case(rightSec_cs)
            4'd0: begin
               sigMin = 1'b0;
               sigHr = 1'b0;
               rightSec_ns = 4'd1; 
            end
                
            4'd1:
                rightSec_ns = 4'd2;
            4'd2:
                rightSec_ns = 4'd3;
            4'd3:
                rightSec_ns = 4'd4;
            4'd4:
                rightSec_ns = 4'd5;
            4'd5:
                rightSec_ns = 4'd6;
            4'd6:
                rightSec_ns = 4'd7;
            4'd7:
                rightSec_ns = 4'd8;
            4'd8:
                rightSec_ns = 4'd9;
            4'd9:
            begin
                rightSec_ns = 4'd0;

                case(leftSec_cs) // Set Next State for Left Second digit after Right second digit reaches 9
                    4'd0:
                        leftSec_ns = 4'd1;
                    4'd1:
                        leftSec_ns = 4'd2;
                    4'd2:
                        leftSec_ns = 4'd3;
                    4'd3:
                        leftSec_ns = 4'd4;
                    4'd4:
                        leftSec_ns = 4'd5;
                    4'd5: begin
                        leftSec_ns = 4'd0;
                        sigMin = 1'b1;   
                    end
                endcase
            end
        endcase
    end

    //Set next state for right minute digit
    always @(*)
    begin
        if(sigMin) begin
            case(rightMin_cs)
                4'd0: begin
                    rightMin_ns = 4'd1;
                end
                4'd1:
                    rightMin_ns = 4'd2;
                4'd2:
                    rightMin_ns = 4'd3;
                4'd3:
                    rightMin_ns = 4'd4;
                4'd4:
                    rightMin_ns = 4'd5;
                4'd5:
                    rightMin_ns = 4'd6;
                4'd6:
                    rightMin_ns = 4'd7;
                4'd7:
                    rightMin_ns = 4'd8;
                4'd8:
                    rightMin_ns = 4'd9;
                4'd9: begin
                        rightMin_ns = 4'd0;

                        case(leftMin_cs) //Set next state for left minute digit after right minute digit reaches 9
                        4'd0:
                            leftMin_ns = 4'd1;
                        4'd1:
                            leftMin_ns = 4'd2;
                        4'd2:
                            leftMin_ns = 4'd3;
                        4'd3:
                            leftMin_ns = 4'd4;
                        4'd4:
                            leftMin_ns = 4'd5;
                        4'd5: begin
                            leftMin_ns = 4'd0;
                            sigHr = 1'b1;
                        end
                    endcase
                end
            endcase
        end
    end

    //Set next state for right hour digit
    always @(*)
    begin
        if(sigHr) begin
            case(rightHr_cs)
                4'd0:
                    rightHr_ns = 4'd1;
                4'd1:
                    rightHr_ns = 4'd2;
                4'd2:
                    rightHr_ns = 4'd3;
                4'd3: begin //If left hour digit = 2 then right hour digit will only reach to 3
                    if(sigTwoFour) begin
                        leftHr_ns = 4'd0;
                        rightHr_ns = 4'd0;
                        sigTwoFour = 1'b0;
                    end else begin
                        rightHr_ns = 4'd4;
                    end
                end
                4'd4:
                    rightHr_ns = 4'd5;
                4'd5:
                    rightHr_ns = 4'd6;
                4'd6:
                    rightHr_ns = 4'd7;
                4'd7:
                    rightHr_ns = 4'd8;
                4'd8:
                    rightHr_ns = 4'd9;
                4'd9: begin
                    rightHr_ns = 4'd0;

                    case(leftHr_cs) //Set left hour digit after right hour digit reaches 9
                        4'd0:
                            leftHr_ns = 4'd1;
                        4'd1: begin
                            sigTwoFour = 4'b1;
                            leftHr_ns = 4'd2;
                        end
                        4'd2:
                            leftHr_ns = 4'd0;
                    endcase
                end
            endcase
        end
    end
endmodule