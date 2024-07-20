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
reg [31:0] counter;
reg [3:0] pattern;
reg [1:0] state;

localparam STATE_IDLE = 2'd0;
localparam STATE_DETECT = 2'd1;
localparam STATE_COUNT = 2'd2;
localparam STATE_DONE = 2'd3;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_IDLE;
        counting <= 0;
        done <= 0;
        pattern <= 0;
        delay <= 0;
        counter <= 0;
        count <= 0;
    end else begin
        case (state)
            STATE_IDLE: begin
                if (pattern == 4'b1101) begin
                    state <= STATE_DETECT;
                    pattern <= 0;
                end else begin
                    pattern <= {pattern[2:0], data};
                end
                counting <= 0;
                done <= 0;
            end
            STATE_DETECT: begin
                if (counter < 4) begin
                    delay[3-counter] <= data;
                    counter <= counter + 1;
                end else begin
                    state <= STATE_COUNT;
                    counter <= 0;
                    counting <= 1;
                end
            end
            STATE_COUNT: begin
                if (counter < (delay + 1) * 1000 - 1) begin
                    counter <= counter + 1;
                    count <= (delay + 1) - (counter / 1000);
                end else begin
                    state <= STATE_DONE;
                    counting <= 0;
                    done <= 1;
                    counter <= 0;
                    count <= 0;
                end
            end
            STATE_DONE: begin
                if (ack) begin
                    state <= STATE_IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

endmodule
