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
reg [3:0] start_pattern;
reg [3:0] state;

parameter IDLE = 4'd0;
parameter START = 4'd1;
parameter SHIFT_DELAY = 4'd2;
parameter COUNTING = 4'd3;
parameter WAIT_ACK = 4'd4;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        start_pattern <= 4'b1101;
    end else begin
        case (state)
            IDLE: begin
                if ({start_pattern[2:0], data} == start_pattern) begin
                    state <= START;
                end
            end
            START: begin
                delay <= 0;
                counter <= 0;
                state <= SHIFT_DELAY;
            end
            SHIFT_DELAY: begin
                delay[3] <= data;
                delay[2:0] <= delay[3:1];
                if (counter == 3) begin
                    state <= COUNTING;
                    counting <= 1;
                end else begin
                    counter <= counter + 1;
                end
            end
            COUNTING: begin
                if (counter == (delay + 1) * 250 - 1) begin
                    counter <= 0;
                    if (delay == 0) begin
                        state <= WAIT_ACK;
                        counting <= 0;
                        done <= 1;
                    end else begin
                        delay <= delay - 1;
                    end
                end else begin
                    counter <= counter + 1;
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    state <= IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = (state == COUNTING) ? delay : 4'bxxxx;

endmodule
