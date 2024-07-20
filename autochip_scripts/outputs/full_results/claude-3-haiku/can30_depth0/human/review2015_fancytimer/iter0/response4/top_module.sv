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
reg [3:0] state;
reg [3:0] pattern;

parameter IDLE = 4'b0000;
parameter DETECT = 4'b0001;
parameter SHIFT = 4'b0010;
parameter COUNT = 4'b0011;
parameter WAIT_ACK = 4'b0100;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        pattern <= 0;
        delay <= 0;
        timer <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    pattern <= {pattern[2:0], data};
                    if (pattern == 4'b1101) begin
                        state <= DETECT;
                    end
                end
            end
            DETECT: begin
                pattern <= 0;
                state <= SHIFT;
            end
            SHIFT: begin
                delay <= {data, delay[3:1]};
                if (delay[0]) begin
                    state <= COUNT;
                    counting <= 1;
                    timer <= delay;
                end
            end
            COUNT: begin
                if (timer == 0) begin
                    counting <= 0;
                    done <= 1;
                    state <= WAIT_ACK;
                end
                else begin
                    timer <= timer - 1;
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    done <= 0;
                    state <= IDLE;
                end
            end
        endcase
    end
end

assign count = timer;

endmodule
