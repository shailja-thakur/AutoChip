module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam STATE_DETECT = 0;
localparam STATE_CAPTURE = 1;
localparam STATE_COUNT = 2;
localparam STATE_NOTIFY = 3;

reg [1:0] state;
reg [3:0] pattern;
reg [3:0] delay;
reg [9:0] counter;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_DETECT;
        pattern <= 0;
        delay <= 0;
        counter <= 0;
        counting <= 0;
        done <= 0;
    end else begin
        case (state)
            STATE_DETECT: begin
                // Shift in data and check for 1101 pattern
                pattern <= {pattern[2:0], data};
                if (pattern == 4'b1101) begin
                    state <= STATE_CAPTURE;
                end
            end
            STATE_CAPTURE: begin
                // Capture the 4-bit delay value
                delay <= {data, delay[2:0]};
                if (delay[3]) begin
                    state <= STATE_COUNT;
                    counter <= 0;
                    counting <= 1;
                end
            end
            STATE_COUNT: begin
                // Count down the delay
                counter <= counter + 1;
                if (counter == (delay + 1) * 1000 - 1) begin
                    state <= STATE_NOTIFY;
                    counting <= 0;
                end
            end
            STATE_NOTIFY: begin
                // Notify the user and wait for acknowledgment
                done <= 1;
                if (ack) begin
                    state <= STATE_DETECT;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = delay - (counter / 1000);

endmodule
