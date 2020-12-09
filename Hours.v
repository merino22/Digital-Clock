module ControllerHours
(
    input clk,
    input[3:0] rightHr,
    input[1:0] leftHr,
    output reg[3:0] RH,
    output reg RPH,
    output reg[3:0] LH,
    output reg LPH
);

    reg[3:0] rightHr_s;
    reg[1:0] leftHr_s;

    always @(posedge clk)
    begin
       rightHr_s <= rightHr;
       leftHr_s <= leftHr; 
    end

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
        