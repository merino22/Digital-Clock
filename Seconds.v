module ControllerSeconds
(
    input clk,
    input [3:0] rightSecs,
    input [2:0] leftSecs,
    output reg[3:0] RS,
    output reg RPS,
    output reg[3:0] LS,
    output reg LPS
);

    reg[2:0] leftSecs_s;
    reg[3:0] rightSecs_s;

    // Set state for left and right second digits
    always @(posedge clk)
    begin
        leftSecs_s <= leftSecs;
        rightSecs_s <= rightSecs;
    end

    // Set LED states for right second digit
    always @(*)
    begin
        case(rightSecs_s)
            4'd0: begin
               RS = 4'b0000;
               RPS = 1'b0;
            end
            4'd1: begin
                RS = 4'b0001;
                RPS = 1'b0;
            end
            4'd2: begin
                RS = 4'b0010;
                RPS = 1'b0;
            end
            4'd3: begin
                RS = 4'b0011;
                RPS = 1'b0;
            end
            4'd4: begin
                RS = 4'b0100;
                RPS = 1'b0;
            end
            4'd5: begin
                RS = 4'b0101;
                RPS = 1'b0;
            end
            4'd6: begin
                RS = 4'b0110;
                RPS = 1'b0;
            end
            4'd7: begin
                RS = 4'b0111;
                RPS = 1'b0;
            end
            4'd8: begin
                RS = 4'b1000;
                RPS = 1'b0;
            end
            4'd9: begin
                RS = 4'b1001;
                RPS = 1'b0;
            end
        endcase
    end

    // Set LED state for left second digit
    always @(*)
    begin
        case(leftSecs_s)
            3'd0: begin
               LS = 3'b000;
               LPS = 1'b0;
            end
            3'd1: begin
                LS = 3'b001;
                LPS = 1'b0;
            end
            3'd2: begin
                LS = 3'b010;
                LPS = 1'b0;
            end
            3'd3: begin
                LS = 3'b011;
                LPS = 1'b0;
            end
            3'd4: begin
                LS = 3'b100;
                LPS = 1'b0;
            end
            3'd5: begin
                LS = 3'b101;
                LPS = 1'b0;
            end
        endcase
    end
endmodule