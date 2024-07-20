module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam IDLE = 2'd0;
localparam DETECT_START = 2'd1;
localparam SHIFT_DURATION = 2'd2;
localparam COUNT_DOWN = 2'd3;

reg [1:0] state;
reg [3:0] duration;
reg [3:0] counter;
reg [3:0] pattern;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        pattern <= 4'b1101;
    end
    else begin
        case (state)
            IDLE: begin
                counting <= 0;
                done <= 0;
                if (data == pattern[3]) begin
                    pattern <= {pattern[2:0], data};
                    if (pattern == 4'b1101) begin
                        state <= DETECT_START;
                    end
                end
                else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            DETECT_START: begin
                pattern <= {pattern[2:0], data};
                if (pattern == 4'b1101) begin
                    state <= SHIFT_DURATION;
                    duration <= 0;
                end
            end
            SHIFT_DURATION: begin
                duration <= {data, duration[3:1]};
                if (duration[0]) begin
                    state <= COUNT_DOWN;
                    counter <= duration;
                    counting <= 1;
                end
            end
            COUNT_DOWN: begin
                if (counter == 0) begin
                    counting <= 0;
                    done <= 1;
                    state <= IDLE;
                end
                else begin
                    counter <= counter - 1;
                end
            end
        endcase
    end
end

assign count = (state == COUNT_DOWN) ? counter : 4'bxxxx;

endmodule
