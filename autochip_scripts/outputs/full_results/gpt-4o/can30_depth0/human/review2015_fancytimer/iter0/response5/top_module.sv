module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

    reg [3:0] state;
    reg [2:0] bit_cnt;
    reg [3:0] delay;
    reg [13:0] cycle_cnt; // Maximum of 8000 cycles (0111_1111_1111 + 0001)

    // State encoding
    localparam IDLE         = 4'b0000,
               DETECT_1101  = 4'b0001,
               SHIFT_DELAY  = 4'b0010,
               COUNTING     = 4'b0011,
               DONE         = 4'b0100;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            bit_cnt <= 0;
            delay <= 0;
            cycle_cnt <= 0;
            counting <= 0;
            done <= 0;
            count <= 4'bxxxx;
        end else begin
            case (state)
                IDLE: begin
                    bit_cnt <= 0;
                    counting <= 0;
                    done <= 0;
                    count <= 4'bxxxx;
                    if (data == 1'b1) begin
                        state <= DETECT_1101;
                        bit_cnt <= 1;
                    end
                end

                DETECT_1101: begin
                    if (data == 1'b1 && bit_cnt == 1) bit_cnt <= 2;
                    else if (data == 0 && bit_cnt == 2) bit_cnt <= 3;
                    else if (data == 1 && bit_cnt == 3) state <= SHIFT_DELAY;
                    else bit_cnt <= 0;
                end

                SHIFT_DELAY: begin
                    delay[3 - bit_cnt] <= data;
                    bit_cnt <= bit_cnt + 1;
                    if (bit_cnt == 3) begin
                        cycle_cnt <= (delay + 1) * 1000;
                        state <= COUNTING;
                        counting <= 1;
                        count <= delay;
                    end
                end

                COUNTING: begin
                    if (cycle_cnt > 0) begin
                        cycle_cnt <= cycle_cnt - 1;
                        if (cycle_cnt % 1000 == 0) count <= count - 1;
                    end else begin
                        state <= DONE;
                        counting <= 0;
                        done <= 1;
                    end
                end

                DONE: begin
                    if (ack) state <= IDLE;
                end

            endcase
        end
    end

endmodule
