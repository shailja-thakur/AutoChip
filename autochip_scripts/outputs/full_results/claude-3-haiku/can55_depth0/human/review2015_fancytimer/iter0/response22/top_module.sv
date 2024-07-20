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
reg [3:0] state;
reg [3:0] pattern;

localparam WAIT_START = 4'd0;
localparam CAPTURE_DELAY = 4'd1;
localparam COUNTING = 4'd2;
localparam WAIT_ACK = 4'd3;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        counting <= 0;
        done <= 0;
        pattern <= 0;
    end else begin
        case (state)
            WAIT_START: begin
                if (data == 1'b1) begin
                    pattern <= {pattern[2:0], data};
                    if (pattern == 4'b1101) begin
                        state <= CAPTURE_DELAY;
                        pattern <= 0;
                    end
                end else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            CAPTURE_DELAY: begin
                delay <= {delay[2:0], data};
                if (delay[3]) begin
                    counter <= delay;
                    state <= COUNTING;
                    counting <= 1;
                end
            end
            COUNTING: begin
                if (counter == 0) begin
                    counting <= 0;
                    done <= 1;
                    state <= WAIT_ACK;
                end else begin
                    counter <= counter - 1;
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    state <= WAIT_START;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = (state == COUNTING) ? counter : 4'bxxxx;

endmodule
