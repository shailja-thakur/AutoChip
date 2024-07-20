module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

// State machine states
localparam STATE_IDLE = 3'd0;
localparam STATE_DETECT_PATTERN = 3'd1;
localparam STATE_SHIFT_DELAY = 3'd2;
localparam STATE_COUNTDOWN = 3'd3;
localparam STATE_NOTIFY = 3'd4;

reg [2:0] state;
reg [3:0] delay;
reg [3:0] counter;

// Pattern detection
reg [3:0] pattern;
always @(posedge clk) begin
    if (reset) begin
        pattern <= 4'b0;
    end else begin
        pattern <= {pattern[2:0], data};
    end
end

// State machine
always @(posedge clk) begin
    if (reset) begin
        state <= STATE_IDLE;
        counting <= 0;
        done <= 0;
        delay <= 0;
        counter <= 0;
    end else begin
        case (state)
            STATE_IDLE: begin
                counting <= 0;
                done <= 0;
                if (pattern == 4'b1101) begin
                    state <= STATE_DETECT_PATTERN;
                end
            end
            STATE_DETECT_PATTERN: begin
                delay <= {data, pattern[3:1]};
                state <= STATE_SHIFT_DELAY;
            end
            STATE_SHIFT_DELAY: begin
                counter <= delay + 1;
                counting <= 1;
                state <= STATE_COUNTDOWN;
            end
            STATE_COUNTDOWN: begin
                counter <= counter - 1;
                if (counter == 0) begin
                    state <= STATE_NOTIFY;
                    counting <= 0;
                    done <= 1;
                end
            end
            STATE_NOTIFY: begin
                if (ack) begin
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
