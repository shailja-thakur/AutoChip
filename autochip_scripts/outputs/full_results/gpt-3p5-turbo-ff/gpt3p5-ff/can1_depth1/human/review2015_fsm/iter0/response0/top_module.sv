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
                    if (data == 1) begin
                        state <= 1;
                    end
                end
                1: begin
                    if (data == 1) begin
                        state <= 2;
                    end else begin
                        state <= 0;
                    end
                end
                2: begin
                    if (data == 0) begin
                        state <= 3;
                    end else begin
                        state <= 0;
                    end
                end
                3: begin
                    if (data == 1) begin
                        state <= 4;
                        shift_ena <= 1;
                    end else begin
                        state <= 0;
                    end
                end
                4: begin
                    if (data == 1) begin
                        state <= 5;
                    end else begin
                        state <= 0;
                    end
                end
                5: begin
                    if (data == 0) begin
                        state <= 6;
                    end else begin
                        state <= 0;
                    end
                end
                6: begin
                    if (data == 1) begin
                        state <= 7;
                    end else begin
                        state <= 0;
                    end
                end
                7: begin
                    if (data == 1) begin
                        state <= 8;
                    end else begin
                        state <= 0;
                    end
                end
                8: begin
                    if (data == 0) begin
                        state <= 9;
                        counting <= 1;
                        shift_ena <= 0;
                    end else begin
                        state <= 0;
                    end
                end
                9: begin
                    if (done_counting) begin
                        state <= 10;
                    end
                end
                10: begin
                    if (ack == 1) begin
                        state <= 0;
                        counting <= 0;
                        done <= 1;
                    end
                end
                default: state <= 0;
            endcase
        end
    end

endmodule
