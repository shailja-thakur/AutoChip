module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );

    reg [1:0] state;
    reg shift_ena;
    reg counting;
    reg done;

    always @(posedge clk or negedge reset) begin
        if (reset) begin
            state <= 0;
        end else begin
            case (state)
                0: begin
                    if (data == 1101) begin
                        state <= 1;
                        shift_ena <= 1;
                    end
                end
                1: begin
                    if (shift_ena) begin
                        shift_ena <= 0;
                        data <= data >> 1;
                    end else if (data == 1101) begin
                        state <= 2;
                        counting <= 1;
                    end
                end
                2: begin
                    if (counting) begin
                        counting <= 0;
                        if (done_counting) begin
                            state <= 3;
                            done <= 1;
                        end
                    end
                end
                3: begin
                    if (ack) begin
                        state <= 0;
                        done <= 0;
                    end
                end
            endcase
        end
    end

endmodule