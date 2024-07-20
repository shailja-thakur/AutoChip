module top_module(
	input clk,
	input reset,
	input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    reg [3:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            case (state)
                0: begin
                    if (data == 1'b1)
                        state <= 1;
                end
                1: begin
                    if (data == 1'b1)
                        state <= 2;
                    else
                        state <= 0;
                end
                2: begin
                    if (data == 1'b0)
                        state <= 3;
                    else
                        state <= 0;
                end
                3: begin
                    if (data == 1'b1)
                        state <= 4;
                    else
                        state <= 0;
                end
                4: begin
                    if (data == 1'b0)
                        state <= 5;
                    else
                        state <= 0;
                end
                5: begin
                    if (data == 1'b1) begin
                        shift_ena <= 1;
                        state <= 6;
                    end else if (done_counting) begin
                        counting <= 1;
                        state <= 7;
                    end else
                        state <= 0;
                end
                6: begin
                    shift_ena <= 0;
                    state <= 0;
                end
                7: begin
                    if (ack) begin
                        done <= 1;
                        state <= 8;
                    end
                end
                8: begin
                    if (ack)
                        state <= 0;
                end
            endcase
        end
    end
endmodule
