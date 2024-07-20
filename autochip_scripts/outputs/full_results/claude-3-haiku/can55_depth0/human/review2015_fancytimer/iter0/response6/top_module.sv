module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

reg [3:0] delay;
reg [3:0] timer;
reg [3:0] pattern;
reg [1:0] state;

localparam IDLE = 2'd0;
localparam DETECT_PATTERN = 2'd1;
localparam COUNT_DELAY = 2'd2;
localparam TIMER_DONE = 2'd3;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 1'b0;
        done <= 1'b0;
        pattern <= 4'b0;
        delay <= 4'b0;
        timer <= 4'b0;
    end else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    pattern <= {pattern[2:0], data};
                    if (pattern == 4'b1101) begin
                        state <= DETECT_PATTERN;
                    end
                end else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            DETECT_PATTERN: begin
                if (data == 1'b1) begin
                    delay[3] <= data;
                end else begin
                    delay[2:0] <= {delay[1:0], data};
                end
                if (delay[3:0] == 4'b1111) begin
                    state <= COUNT_DELAY;
                    counting <= 1'b1;
                    timer <= delay;
                end
            end
            COUNT_DELAY: begin
                if (timer == 4'b0) begin
                    state <= TIMER_DONE;
                    counting <= 1'b0;
                    done <= 1'b1;
                end else begin
                    timer <= timer - 1;
                end
            end
            TIMER_DONE: begin
                if (ack == 1'b1) begin
                    state <= IDLE;
                    done <= 1'b0;
                end
            end
        endcase
    end
end

assign count = counting ? timer : 4'bxxxx;

endmodule
