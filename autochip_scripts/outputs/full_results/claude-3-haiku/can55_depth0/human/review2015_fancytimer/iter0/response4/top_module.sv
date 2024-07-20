module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam STATE_WAIT_START = 0,
          STATE_RECEIVE_DURATION = 1,
          STATE_COUNTING = 2,
          STATE_WAIT_ACK = 3;

reg [1:0] state;
reg [3:0] pattern;
reg [3:0] duration;
reg [15:0] counter;

always @(posedge clk) begin
    if (reset) begin
        state <= STATE_WAIT_START;
        pattern <= 4'b0000;
        duration <= 4'b0000;
        counting <= 1'b0;
        done <= 1'b0;
        counter <= 16'b0;
    end else begin
        case (state)
            STATE_WAIT_START: begin
                if (pattern == 4'b1101) begin
                    state <= STATE_RECEIVE_DURATION;
                    pattern <= 4'b0000;
                end else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            STATE_RECEIVE_DURATION: begin
                if (counter == 4) begin
                    state <= STATE_COUNTING;
                    counter <= 16'b0;
                    duration <= {data, duration[3:1]};
                end else begin
                    counter <= counter + 1;
                end
            end
            STATE_COUNTING: begin
                if (counter == (duration + 1) * 1000 - 1) begin
                    state <= STATE_WAIT_ACK;
                    counting <= 1'b0;
                    done <= 1'b1;
                    counter <= 16'b0;
                end else begin
                    counter <= counter + 1;
                    counting <= 1'b1;
                end
            end
            STATE_WAIT_ACK: begin
                if (ack) begin
                    state <= STATE_WAIT_START;
                    done <= 1'b0;
                end
            end
        endcase
    end
end

assign count = (state == STATE_COUNTING) ? duration - (counter / 1000) : 4'b0000;

endmodule
