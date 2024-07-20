module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] state;
    reg [3:0] delay;
    reg [13:0] counter;
    reg [3:0] match_shift;
    reg [2:0] bit_count;

    // Define states
    localparam IDLE = 4'b0000,
               MATCH_1101 = 4'b0001,
               READ_DELAY = 4'b0010,
               COUNTDOWN = 4'b0011,
               WAIT_ACK = 4'b0100;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            counting <= 0;
            done <= 0;
            bit_count <= 0;
            match_shift <= 4'b0000;
            delay <= 4'b0000;
            counter <= 14'b0;
        end else begin
            case (state)
                IDLE: begin
                    counting <= 0;
                    done <= 0;
                    // Match the input pattern 1101
                    match_shift <= {match_shift[2:0], data};
                    if (match_shift == 4'b1101) begin
                        state <= MATCH_1101;
                        bit_count <= 0;
                    end
                end
                MATCH_1101: begin
                    // Shift in the delay bits MSB first
                    delay[3] <= data;
                    bit_count <= bit_count + 1;
                    if (bit_count == 3) begin
                        state <= READ_DELAY;
                        bit_count <= 0;
                    end
                end
                READ_DELAY: begin
                    // Continue shifting in the delay bits MSB first
                    delay[2 - bit_count] <= data;
                    bit_count <= bit_count + 1;
                    if (bit_count == 3) begin
                        state <= COUNTDOWN;
                        counting <= 1;
                        counter <= (delay + 1) * 1000;
                        count <= delay;
                    end
                end
                COUNTDOWN: begin
                    if (counter > 0) begin
                        counter <= counter - 1;
                        if (counter % 1000 == 0) begin
                            if (count > 0) begin
                                count <= count - 1;
                            end else begin
                                count <= 0;
                            end
                        end
                    end else begin
                        counting <= 0;
                        done <= 1;
                        state <= WAIT_ACK;
                    end
                end
                WAIT_ACK: begin
                    if (ack) begin
                        state <= IDLE;
                        done <= 0;
                    end
                end
                default: state <= IDLE;
            endcase
        end
    end

endmodule
