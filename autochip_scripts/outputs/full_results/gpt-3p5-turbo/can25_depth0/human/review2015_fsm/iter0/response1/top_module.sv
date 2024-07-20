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

    always @(posedge clk) begin
        if (reset) begin
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
            state <= 0;
        end else begin
            case (state)
                0: begin
                    if (data) begin
                        state <= 1;
                    end
                end
                1: begin
                    if (data) begin
                        state <= 2;
                    end else begin
                        state <= 0;
                    end
                end
                2: begin
                    if (data) begin
                        state <= 3;
                        shift_ena <= 1;
                    end else begin
                        state <= 0;
                    end
                end
                3: begin
                    if (data) begin
                        state <= 3;
                    end else begin
                        state <= 4;
                        shift_ena <= 0;
                        counting <= 1;
                    end
                end
                4: begin
                    if (done_counting) begin
                        state <= 5;
                        done <= 1;
                    end
                end
                5: begin
                    if (ack) begin
                        state <= 0;
                        done <= 0;
                    end
                end
                default: state <= 0;
            endcase
        end
    end
endmodule
