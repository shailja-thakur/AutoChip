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
parameter IDLE = 4'b0000, DETECT = 4'b0001, SHIFT = 4'b0010, COUNT = 4'b0011, NOTIFY = 4'b0100;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (data == 1'b1 && {data, data, data, data} == 4'b1101) begin
                    state <= SHIFT;
                end
            end
            SHIFT: begin
                delay <= {data, data, data, data};
                state <= COUNT;
            end
            COUNT: begin
                counting <= 1;
                counter <= delay;
                if (counter == 0) begin
                    state <= NOTIFY;
                    counting <= 0;
                end else begin
                    counter <= counter - 1;
                end
            end
            NOTIFY: begin
                done <= 1;
                if (ack == 1'b1) begin
                    state <= IDLE;
                    done <= 0;
                end
            end
            default: state <= IDLE;
        endcase
    end
end

assign count = (state == COUNT) ? counter : 4'bxxxx;

endmodule
