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
    reg [3:0] counter;
    reg shift_ena_reg;
    reg counting_reg;
    reg done_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            case (state)
                IDLE: begin
                    if (data == 1101) begin
                        state <= SHIFT_ENA;
                        shift_ena_reg <= 1;
                        counter <= 4;
                    end
                end
                SHIFT_ENA: begin
                    if (counter == 0) begin
                        state <= COUNTING;
                        shift_ena_reg <= 0;
                        counting_reg <= 1;
                    end
                end
                COUNTING: begin
                    if (done_counting) begin
                        state <= DONE;
                        counting_reg <= 0;
                        done_reg <= 1;
                    end
                end
                DONE: begin
                    if (ack) begin
                        state <= IDLE;
                        done_reg <= 0;
                    end
                end
            endcase
        end
    end

    assign shift_ena = shift_ena_reg;
    assign counting = counting_reg;
    assign done = done_reg;

endmodule