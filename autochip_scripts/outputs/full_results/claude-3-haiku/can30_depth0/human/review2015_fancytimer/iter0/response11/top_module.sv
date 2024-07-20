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
reg [3:0] counter;
reg [3:0] pattern;
reg [1:0] state;

localparam STATE_SEARCH = 2'b00;
localparam STATE_COUNT = 2'b01;
localparam STATE_DONE = 2'b10;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_SEARCH;
        counting <= 0;
        done <= 0;
        pattern <= 4'b0;
        delay <= 4'b0;
        counter <= 4'b0;
    end
    else begin
        case (state)
            STATE_SEARCH: begin
                if (pattern == 4'b1101) begin
                    state <= STATE_COUNT;
                    delay <= {data, data, data, data};
                    counter <= delay + 1;
                    counting <= 1;
                end
                else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            STATE_COUNT: begin
                if (counter == 0) begin
                    state <= STATE_DONE;
                    counting <= 0;
                    done <= 1;
                end
                else begin
                    counter <= counter - 1;
                end
            end
            STATE_DONE: begin
                if (ack) begin
                    state <= STATE_SEARCH;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = (state == STATE_COUNT) ? counter : 4'bxxxx;

endmodule
