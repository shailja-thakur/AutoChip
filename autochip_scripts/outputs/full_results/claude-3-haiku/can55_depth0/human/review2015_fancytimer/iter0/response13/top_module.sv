module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam STATE_WAIT = 0;
localparam STATE_START = 1;
localparam STATE_SHIFT = 2;
localparam STATE_COUNT = 3;
localparam STATE_DONE = 4;

reg [2:0] state;
reg [3:0] pattern;
reg [3:0] delay;
reg [9:0] counter;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT;
        pattern <= 4'b0;
        delay <= 4'b0;
        counter <= 10'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end else begin
        case (state)
            STATE_WAIT: begin
                // Wait for the start sequence (1101)
                if (data) begin
                    pattern <= {pattern[2:0], data};
                    if (pattern == 4'b1101) begin
                        state <= STATE_START;
                    end
                end else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            STATE_START: begin
                // Shift in the delay value
                pattern <= {pattern[2:0], data};
                delay <= {pattern[2:0], data};
                state <= STATE_SHIFT;
            end
            STATE_SHIFT: begin
                // Wait until the delay value has been shifted in
                if (counter == 4) begin
                    state <= STATE_COUNT;
                    counting <= 1'b1;
                    counter <= 10'b0;
                end else begin
                    counter <= counter + 1;
                end
            end
            STATE_COUNT: begin
                // Count down the timer
                if (counter == (delay + 1) * 1000 - 1) begin
                    state <= STATE_DONE;
                    counting <= 1'b0;
                    done <= 1'b1;
                    counter <= 10'b0;
                end else begin
                    counter <= counter + 1;
                    count <= delay - (counter / 1000);
                end
            end
            STATE_DONE: begin
                // Wait for acknowledgement
                if (ack) begin
                    state <= STATE_WAIT;
                    done <= 1'b0;
                end
            end
        endcase
    end
end

endmodule
