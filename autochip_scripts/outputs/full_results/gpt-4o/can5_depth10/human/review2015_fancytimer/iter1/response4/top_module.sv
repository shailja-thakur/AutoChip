module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] pattern;
    reg [3:0] delay;
    reg [11:0] counter; // enough to handle up to 16000 cycles (16*1000)
    reg [2:0] state;
    reg [2:0] bits_received; // counting 0 to 3

    localparam IDLE = 3'b000,
               PATTERN1 = 3'b001,
               PATTERN2 = 3'b010,
               PATTERN3 = 3'b011,
               PATTERN4 = 3'b100,
               LOAD_DELAY = 3'b101,
               COUNTDOWN = 3'b110,
               DONE = 3'b111;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            pattern <= 4'b0;
            delay <= 4'b0;
            counter <= 12'b0;
            count <= 4'b0;
            counting <= 1'b0;
            done <= 1'b0;
            bits_received <= 3'b0;
        end else begin
            case (state)
                IDLE: begin
                    done <= 1'b0;
                    counting <= 1'b0;
                    if (data == 1'b1)
                        state <= PATTERN1;
                end
                PATTERN1: begin
                    if (data == 1'b1)
                        state <= PATTERN2;
                    else
                        state <= IDLE;
                end
                PATTERN2: begin
                    if (data == 1'b0)
                        state <= PATTERN3;
                    else
                        state <= IDLE;
                end
                PATTERN3: begin
                    if (data == 1'b1)
                        state <= PATTERN4;
                    else
                        state <= IDLE;
                end
                PATTERN4: begin
                    state <= LOAD_DELAY;
                end
                LOAD_DELAY: begin
                    delay <= {delay[2:0], data};
                    if (bits_received < 3) begin
                        bits_received <= bits_received + 1;
                    end else begin
                        counter <= (({delay[2:0], data}) + 1) * 1000;
                        count <= (({delay[2:0], data}) + 1) - 1;
                        state <= COUNTDOWN;
                        counting <= 1'b1;
                    end
                end
                COUNTDOWN: begin
                    if (counter > 0) begin
                        counter <= counter - 1;
                        if (counter % 1000 == 0 && count > 0) begin
                            count <= count - 1;
                        end
                    end else begin
                        state <= DONE;
                        counting <= 1'b0;
                        done <= 1'b1;
                    end
                end
                DONE: begin
                    if (ack) begin
                        state <= IDLE;
                        bits_received <= 3'b0;
                        delay <= 4'b0;
                    end
                end
            endcase
        end
    end
endmodule
