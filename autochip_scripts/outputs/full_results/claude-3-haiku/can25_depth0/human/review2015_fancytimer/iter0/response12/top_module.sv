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
parameter IDLE = 0, START = 1, WAIT = 2, COUNT = 3, NOTIFY = 4;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (data == 1'b1 && {data, data, data, data} == 4'b1101) begin
                    state <= START;
                end
            end
            START: begin
                delay <= {data, data, data, data};
                state <= WAIT;
            end
            WAIT: begin
                counting <= 1;
                state <= COUNT;
                counter <= 0;
            end
            COUNT: begin
                counter <= counter + 1;
                if (counter == delay) begin
                    counting <= 0;
                    state <= NOTIFY;
                end
            end
            NOTIFY: begin
                done <= 1;
                if (ack) begin
                    state <= IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = (state == COUNT) ? delay - counter : 4'bxxxx;

endmodule
