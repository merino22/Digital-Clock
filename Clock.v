module Clock
(
    input clk,
    input rst,
    output reg[3:0] rightSec_cs,
    output reg[2:0] leftSec_cs,
    output reg[3:0] rightMin_cs,
    output reg[2:0] leftMin_cs,
    output reg[3:0] rightHr_cs,
    output reg[1:0] leftHr_cs
);

    reg sigMin;
    reg[3:0] rightSec_ns;
    reg[2:0] leftSec_ns;

    reg sigHr;
    reg[3:0] rightMin_ns;
    reg[2:0] leftMin_ns;

    reg[3:0] rightHr_ns;
    reg[1:0] leftHr_ns;

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
        end else
            rightSec_cs <= rightSec_ns;
            leftSec_cs <= leftSec_ns;
            rightMin_cs <= rightMin_ns;
            leftMin_cs <= leftMin_ns;
            rightHr_cs <= rightHr_ns;
            leftHr_cs <= leftHr_ns;
    end

    // Set next state for Right Seconds
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

                // Set Next State for Left Seconds after Right Second = 9
                case(leftSec_cs)
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

                        case(leftMin_cs)
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
                4'd3:
                    rightHr_ns = 4'd4;
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

                    case(leftHr_cs)
                        4'd0:
                            leftHr_ns = 4'd1;
                        4'd1:
                            leftHr_ns = 4'd2;
                        4'd2:
                            leftHr_ns = 4'd0;
                    endcase
                end
            endcase
        end
    end
endmodule