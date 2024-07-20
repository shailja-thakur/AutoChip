module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

localparam WAIT_START = 3'b000;
localparam WAIT_DURATION = 3'b001;
localparam COUNTING = 3'b010;
localparam WAIT_ACK = 3'b011;

reg [2:0] state;
reg [3:0] pattern;
reg [3:0] delay;
reg [13:0] timer;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= WAIT_START;
        counting <= 0;
        done <= 0;
        pattern <= 0;
        delay <= 0;
        timer <= 0;
    end else begin
        case (state)
            WAIT_START: begin
                if (pattern == 4'b1101) begin
                    state <= WAIT_DURATION;
                    pattern <= 0;
                end else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            WAIT_DURATION: begin
                if (pattern == 4'b0000) begin
                    state <= COUNTING;
                    delay <= 0;
                end else begin
                    pattern <= {pattern[2:0], data};
                    delay <= {pattern[2:0], data};
                end
            end
            COUNTING: begin
                if (timer == (delay + 1) * 1000 - 1) begin
                    state <= WAIT_ACK;
                    counting <= 0;
                    done <= 1;
                    timer <= 0;
                end else begin
                    timer <= timer + 1;
                    counting <= 1;
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

assign count = (state == COUNTING) ? (delay - timer / 1000) : 4'bxxxx;

endmodule
