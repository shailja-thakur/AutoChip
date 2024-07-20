module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] remaining;
    reg [3:0] count_reg;
    reg [3:0] next_count_reg;
    reg start;
    reg [3:0] state;

    always @(posedge clk) begin
        if (reset) begin
            counting <= 0;
            done <= 0;
            delay <= 0;
            remaining <= 0;
            count_reg <= 0;
            next_count_reg <= 0;
            start <= 0;
            state <= 0;
        end else begin
            case(state)
                0: begin // Searching for start sequence 1101
                    if (data == 4'b1101) begin
                        start <= 1;
                        state <= 1;
                    end else begin
                        start <= 0;
                        state <= 0;
                    end
                end
                1: begin // Shifting in 4 bits for delay
                    start <= 0;
                    count_reg <= delay;
                    next_count_reg <= delay - 1;
                    state <= 2;
                end
                2: begin // Counting
                    counting <= 1;
                    count_reg <= next_count_reg;
                    next_count_reg <= next_count_reg - 1;
                    if (count_reg == 0) begin
                        counting <= 0;
                        state <= 3;
                    end
                end
                3: begin // Done, waiting for ack to reset
                    counting <= 0;
                    done <= 1;
                    if (ack) begin
                        done <= 0;
                        state <= 0;
                    end else begin
                        done <= 1;
                        state <= 3;
                    end
                end
            endcase
        end
    end

    assign count = counting ? count_reg : 4'bxxxx;

endmodule
