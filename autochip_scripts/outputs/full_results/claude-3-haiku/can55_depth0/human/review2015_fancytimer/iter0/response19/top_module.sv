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

parameter WAIT_START = 2'b00;
parameter LOAD_DELAY = 2'b01;
parameter COUNT_DOWN = 2'b10;
parameter WAIT_ACK = 2'b11;

always @(posedge clk) begin
    if (reset) begin
        state <= WAIT_START;
        pattern <= 4'b0;
        delay <= 4'b0;
        counter <= 4'b0;
        counting <= 1'b0;
        done <= 1'b0;
    end
    else begin
        case (state)
            WAIT_START: begin
                if (pattern == 4'b1101) begin
                    state <= LOAD_DELAY;
                end
                else begin
                    pattern <= {pattern[2:0], data};
                end
            end
            LOAD_DELAY: begin
                delay <= {data, delay[3:1]};
                counter <= {data, delay[3:1]};
                state <= COUNT_DOWN;
                counting <= 1'b1;
            end
            COUNT_DOWN: begin
                if (counter == 0) begin
                    counting <= 1'b0;
                    done <= 1'b1;
                    state <= WAIT_ACK;
                end
                else begin
                    counter <= counter - 1;
                end
            end
            WAIT_ACK: begin
                if (ack) begin
                    state <= WAIT_START;
                    done <= 1'b0;
                end
            end
        endcase
    end
end

assign count = counting ? counter : 4'bxxxx;

endmodule
