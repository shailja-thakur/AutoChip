module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

reg [3:0] delay;
reg [11:0] counter;
reg [3:0] state;
reg [3:0] pattern;

parameter IDLE = 4'd0;
parameter START_DETECTED = 4'd1;
parameter SHIFT_DELAY = 4'd2;
parameter COUNTING = 4'd3;
parameter DONE = 4'd4;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 1'b0;
        done <= 1'b0;
        pattern <= 4'b0;
        delay <= 4'b0;
        counter <= 12'b0;
    end
    else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    pattern <= {pattern[2:0], data};
                    if (pattern == 4'b1101) begin
                        state <= START_DETECTED;
                        pattern <= 4'b0;
                    end
                end
                else begin
                    pattern <= {pattern[2:0], data};
                end
            end

            START_DETECTED: begin
                pattern <= {data, pattern[3:1]};
                if (pattern == 4'b0000) begin
                    delay <= {data, pattern[3:1]};
                    state <= SHIFT_DELAY;
                    counter <= 12'b0;
                end
            end

            SHIFT_DELAY: begin
                if (counter == 12'h0ff) begin
                    counter <= 12'b0;
                    state <= COUNTING;
                    counting <= 1'b1;
                end
                else begin
                    counter <= counter + 1'b1;
                    pattern <= {data, pattern[3:1]};
                    delay <= {data, delay[3:1]};
                end
            end

            COUNTING: begin
                if (counter == (delay + 1) * 1000 - 1) begin
                    counter <= 12'b0;
                    if (delay == 4'b0) begin
                        state <= DONE;
                        counting <= 1'b0;
                        done <= 1'b1;
                    end
                    else begin
                        delay <= delay - 1'b1;
                    end
                end
                else begin
                    counter <= counter + 1'b1;
                end
                count <= delay;
            end

            DONE: begin
                if (ack) begin
                    state <= IDLE;
                    done <= 1'b0;
                end
            end

            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
