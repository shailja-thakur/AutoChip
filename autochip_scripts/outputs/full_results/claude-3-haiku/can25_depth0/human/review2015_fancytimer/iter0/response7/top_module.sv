module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam STATE_IDLE = 3'd0;
localparam STATE_DETECT_PATTERN = 3'd1;
localparam STATE_LOAD_DELAY = 3'd2;
localparam STATE_COUNTING = 3'd3;
localparam STATE_NOTIFY = 3'd4;

reg [2:0] state;
reg [3:0] delay;
reg [3:0] counter;
reg [3:0] pattern;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_IDLE;
        counting <= 0;
        done <= 0;
        pattern <= 4'b1101;
    end else begin
        case (state)
            STATE_IDLE: begin
                // Search for the start pattern (1101)
                if (data == pattern[3]) begin
                    pattern <= {pattern[2:0], data};
                    if (pattern == 4'b1101) begin
                        state <= STATE_DETECT_PATTERN;
                    end
                end else begin
                    pattern <= 4'b1101;
                end
            end

            STATE_DETECT_PATTERN: begin
                // Shift in the delay value
                delay <= {delay[2:0], data};
                if (delay[3]) begin
                    state <= STATE_LOAD_DELAY;
                end
            end

            STATE_LOAD_DELAY: begin
                // Start the timer
                counting <= 1;
                counter <= delay + 1;
                state <= STATE_COUNTING;
            end

            STATE_COUNTING: begin
                // Decrement the timer
                counter <= counter - 1;
                if (counter == 0) begin
                    counting <= 0;
                    done <= 1;
                    state <= STATE_NOTIFY;
                end
            end

            STATE_NOTIFY: begin
                // Wait for the user to acknowledge
                if (ack) begin
                    done <= 0;
                    state <= STATE_IDLE;
                end
            end

            default: begin
                state <= STATE_IDLE;
            end
        endcase
    end
end

assign count = counter;

endmodule
