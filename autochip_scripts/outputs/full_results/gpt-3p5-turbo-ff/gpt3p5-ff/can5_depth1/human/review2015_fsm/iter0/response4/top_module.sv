module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack );

    reg [2:0] state;

    always @(posedge clk) begin
        if (reset || done) begin
            state <= 3'b000;
            shift_ena <= 0;
            counting <= 0;
            done <= 0;
        end else begin
            case (state)
                3'b000: begin // State 0: Searching for start sequence (1101)
                    if (data) begin
                        state <= 3'b001;
                        shift_ena <= 0;
                        counting <= 0;
                        done <= 0;
                    end else begin
                        state <= 3'b000;
                        shift_ena <= 0;
                        counting <= 0;
                        done <= 0;
                    end
                end

                3'b001: begin // State 1: Start sequence detected, asserting shift_ena for 4 clock cycles
                    if (shift_ena < 4) begin
                        shift_ena <= shift_ena + 1;
                    end else begin
                        state <= 3'b010;
                        shift_ena <= 0;
                        counting <= 1;
                        done <= 0;
                    end
                end

                3'b010: begin // State 2: Waiting for counters to finish counting
                    if (done_counting) begin
                        state <= 3'b011;
                        shift_ena <= 0;
                        counting <= 0;
                        done <= 0;
                    end else begin
                        state <= 3'b010;
                        shift_ena <= 0;
                        counting <= 0;
                        done <= 0;
                    end
                end

                3'b011: begin // State 3: Timer timed out, waiting for ack
                    if (ack) begin
                        state <= 3'b000;
                        shift_ena <= 0;
                        counting <= 0;
                        done <= 1;
                    end else begin
                        state <= 3'b011;
                        shift_ena <= 0;
                        counting <= 0;
                        done <= 0;
                    end
                end
            endcase
        end
    end

endmodule
