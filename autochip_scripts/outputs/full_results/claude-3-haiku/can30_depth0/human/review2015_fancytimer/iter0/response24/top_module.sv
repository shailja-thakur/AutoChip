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
reg [3:0] timer_count;
reg [3:0] pattern;
reg [1:0] state;

localparam WAIT_PATTERN = 2'd0;
localparam SHIFT_DELAY  = 2'd1;
localparam COUNT_DELAY  = 2'd2;
localparam WAIT_ACK     = 2'd3;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= WAIT_PATTERN;
        pattern <= 0;
        delay <= 0;
        timer_count <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        case (state)
            WAIT_PATTERN: begin
                if (pattern == 4'b1101) begin
                    state <= SHIFT_DELAY;
                    pattern <= 0;
                end
                else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            SHIFT_DELAY: begin
                if (timer_count == 4'd3) begin
                    state <= COUNT_DELAY;
                    timer_count <= 0;
                end
                else begin
                    delay[3 - timer_count] = data;
                    timer_count <= timer_count + 1;
                end
            end
            COUNT_DELAY: begin
                if (timer_count == delay) begin
                    state <= WAIT_ACK;
                    counting <= 0;
                    done <= 1;
                end
                else begin
                    timer_count <= timer_count + 1;
                    counting <= 1;
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    state <= WAIT_PATTERN;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = timer_count;

endmodule
