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

parameter IDLE = 4'b0000;
parameter START = 4'b0001;
parameter DELAY = 4'b0010;
parameter COUNT = 4'b0011;
parameter DONE = 4'b0100;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        pattern <= 0;
        delay <= 0;
        counter <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    pattern <= {pattern[2:0], data};
                    if (pattern == 4'b1101) begin
                        state <= START;
                    end
                end else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            START: begin
                if (data == 1'b1) begin
                    delay <= {delay[2:0], data};
                    if (delay[3]) begin
                        state <= DELAY;
                        counter <= delay;
                        counting <= 1;
                    end
                end else begin
                    delay <= {delay[2:0], data};
                end
            end
            DELAY: begin
                if (counter == 0) begin
                    state <= COUNT;
                    counter <= delay + 1;
                end else begin
                    counter <= counter - 1;
                end
            end
            COUNT: begin
                if (counter == 0) begin
                    state <= DONE;
                    counting <= 0;
                    done <= 1;
                end else begin
                    counter <= counter - 1;
                end
            end
            DONE: begin
                if (ack) begin
                    state <= IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = (state == COUNT || state == DONE) ? counter : 4'bxxxx;

endmodule
