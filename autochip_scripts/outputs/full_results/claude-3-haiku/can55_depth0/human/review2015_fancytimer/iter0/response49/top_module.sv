module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

parameter WAITING = 3'd0, DETECTED = 3'd1, COUNTING = 3'd2, DONE = 3'd3;
reg [2:0] state;
reg [3:0] pattern, delay;
reg [9:0] counter;

always @(posedge clk) begin
    if (reset) begin
        state <= WAITING;
        counting <= 0;
        done <= 0;
        pattern <= 4'b0;
        delay <= 4'b0;
        counter <= 10'b0;
    end
    else begin
        case (state)
            WAITING: begin
                if (data == 1'b1) begin
                    pattern <= {pattern[2:0], data};
                    if (pattern == 4'b1101) begin
                        state <= DETECTED;
                    end
                end
                else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            DETECTED: begin
                if (counter < 4) begin
                    delay[3-counter] <= data;
                    counter <= counter + 1;
                end
                else begin
                    state <= COUNTING;
                    counting <= 1;
                    counter <= 0;
                end
            end
            COUNTING: begin
                if (counter < (delay + 1) * 1000 - 1) begin
                    counter <= counter + 1;
                end
                else begin
                    state <= DONE;
                    counting <= 0;
                    done <= 1;
                    counter <= 0;
                end
            end
            DONE: begin
                if (ack) begin
                    state <= WAITING;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = (state == COUNTING) ? delay - (counter / 1000) : 4'bx;

endmodule
