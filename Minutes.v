module ControllerMinutes
(
    input clk,
    input [3:0] rightMin,
    input [2:0] leftMin,
    input [3:0] setRMin,
    input [2:0] setLMin,
    input setSignal,
    input alarmSignal,
    input setLMSignal,
    input setRMSignal,
    input clk2,
    output reg [3:0] RM,
    output reg RP,
    output reg [3:0] LM,
    output reg LP
);

    reg [3:0] rightMin_s;
    reg [2:0] leftMin_s;

    //Second clk used for setting states when setSignal or alarmSignal is on
    always @(posedge clk2)
    begin
	if(setSignal) begin
        if(alarmSignal == 0) begin
            if(setLMSignal)
                leftMin_s <= setLMin;
            else if(setRMSignal)
                rightMin_s <= setRMin; 
        end
    end else begin
        if(alarmSignal) begin
            if(setLMSignal)
                leftMin_s <= setLMin;
            else if(setRMSignal)
                rightMin_s <= setRMin; 
        end
    end
    end

    // Set state of left and right minute digits
    always @(posedge clk)
    begin
	    rightMin_s <= rightMin;
        leftMin_s <= leftMin;   
    end

    // Set LED for Right Minutes
    always @(*)
    begin
        case(rightMin_s)
            4'd0: begin
               RM = 4'b0000;
               RP = 1'b0;
            end
            4'd1: begin
                RM = 4'b0001;
                RP = 1'b0;
            end
            4'd2: begin
                RM = 4'b0010;
                RP = 1'b0;
            end
            4'd3: begin
                RM = 4'b0011;
                RP = 1'b0;
            end
            4'd4: begin
                RM = 4'b0100;
                RP = 1'b0;
            end
            4'd5: begin
                RM = 4'b0101;
                RP = 1'b0;
            end
            4'd6: begin
                RM = 4'b0110;
                RP = 1'b0;
            end
            4'd7: begin
                RM = 4'b0111;
                RP = 1'b0;
            end
            4'd8: begin
                RM = 4'b1000;
                RP = 1'b0;
            end
            4'd9: begin
                RM = 4'b1001;
                RP = 1'b0;
            end
        endcase
    end

    // Set LED for Left Minutes
    always @(*)
    begin
        case(leftMin_s)
            3'd0: begin
               LM = 3'b000;
               LP = 1'b0;
            end
            3'd1: begin
                LM = 3'b001;
                LP = 1'b0;
            end
            3'd2: begin
                LM = 3'b010;
                LP = 1'b0;
            end
            3'd3: begin
                LM = 3'b011;
                LP = 1'b0;
            end
            3'd4: begin
                LM = 3'b100;
                LP = 1'b0;
            end
            3'd5: begin
                LM = 3'b101;
                LP = 1'b0;
            end
        endcase
    end
endmodule