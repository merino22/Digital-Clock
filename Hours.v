module ControllerHours
(
    input clk,
    input[3:0] rightHr,
    input[1:0] leftHr,
    input setSignal,
    input alarmSignal,
    input setLHSignal,
    input setRHSignal,
    input [1:0]setLHr,
    input [3:0]setRHr,
    input clk2,
    output reg[3:0] RH,
    output reg RPH,
    output reg[3:0] LH,
    output reg LPH
);

    //Registers for right hour and left hour digits
    reg[3:0] rightHr_s;
    reg[1:0] leftHr_s;

    // Set state of left and right hour digits to the state being inputted from Clock
    always @(posedge clk)
    begin
	    rightHr_s <= rightHr;
        leftHr_s <= leftHr;
    end

    // Second clk which sets left and right hour digits to state being inputted from ControllerSetNumberOutput 
    always @(posedge clk2)
    begin
       if(setSignal) begin //Setting of digits if setSignal is on and alarmSignal is off
           if(alarmSignal == 0) begin
                if(setLHSignal) 
                    leftHr_s <= setLHr;
                else if(setRHSignal)
                    rightHr_s <= setRHr;
           end
       end else begin
           if(alarmSignal) begin // Setting of digits if setSignal is off and alarmSignal is on
               if(setLHSignal)
                    leftHr_s <= setLHr;
                else if(setRHSignal)
                    rightHr_s <= setRHr;
           end
       end
    end

    // Set right hour digit value for LED Number display
    always @(*)
    begin
        case(rightHr_s)
            4'd0: begin
                RH = 4'b0000;
                RPH = 1'b0;
            end
            4'd1: begin
                RH = 4'b0001;
                RPH = 1'b0;
            end
            4'd2: begin
                RH = 4'b0010;
                RPH = 1'b0;
            end
            4'd3: begin
                RH = 4'b0011;
                RPH = 1'b0;
            end
            4'd4: begin
                RH = 4'b0100;
                RPH = 1'b0;
            end
            4'd5: begin
                RH = 4'b0101;
                RPH = 1'b0;
            end
            4'd6: begin
                RH = 4'b0110;
                RPH = 1'b0;
            end
            4'd7: begin
                RH = 4'b0111;
                RPH = 1'b0;
            end
            4'd8: begin
                RH = 4'b1000;
                RPH = 1'b0;
            end
            4'd9: begin
                RH = 4'b1001;
                RPH = 1'b0;
            end
        endcase
    end

    // Set left hour digit value for LED Number display
    always @(*)
    begin
        case(leftHr_s)
            2'd0: begin
                LH = 4'b0000;
                LPH = 1'b0;
            end
            2'd1: begin
                LH = 4'b0001;
                LPH = 1'b0;
            end
            2'd2: begin
                LH = 4'b0010;
                LPH = 1'b0;
            end
            2'd3: begin
                LH = 4'b0011;
                LPH = 1'b0;
            end
        endcase
    end     
endmodule