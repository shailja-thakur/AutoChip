module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

reg [3:0] delay;
reg [3:0] timer;
reg [15:0] counter;
reg [3:0] state;

parameter START = 4'b0000;
parameter SEARCH = 4'b0001;
parameter SHIFT = 4'b0010;
parameter COUNT = 4'b0011;
parameter NOTIFY = 4'b0100;
parameter WAIT = 4'b0101;
parameter RESET = 4'b0110;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= RESET;
    else begin
        case (state)
            START: begin
                if (data == 4'b1101)
                    state <= SEARCH;
                else
                    state <= START;
            end
            SEARCH: begin
                state <= SHIFT;
            end
            SHIFT: begin
                state <= COUNT;
                delay <= data;
                counter <= 0;
                counting <= 1;
            end
            COUNT: begin
                if (counter < (delay + 1) * 1000 - 1) begin
                    counter <= counter + 1;
                end
                else begin
                    state <= NOTIFY;
                    counter <= 0;
                    counting <= 0;
                end
            end
            NOTIFY: begin
                if (ack) begin
                    state <= WAIT;
                    done <= 1;
                end
                else
                    state <= NOTIFY;
            end
            WAIT: begin
                if (ack) begin
                    state <= START;
                    done <= 0;
                end
                else
                    state <= WAIT;
            end
            RESET: begin
                state <= START;
                done <= 0;
            end
        endcase
    end
end

assign count = counting ? delay : 4'bZZZZ;

endmodule
