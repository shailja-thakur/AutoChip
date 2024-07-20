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

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (data == 1'b1) begin
                    state <= DETECT;
                end
            end
            DETECT: begin
                if (data == 1'b1) begin
                    state <= DETECT;
                end else if (data == 1'b0) begin
                    state <= SHIFT;
                    counter <= 0;
                end
            end
            SHIFT: begin
                counter <= counter + 1;
                if (counter < 4) begin
                    delay[3 - counter] <= data;
                end
                if (counter == 4) begin
                    state <= COUNT;
                    counter <= 0;
                    counting <= 1;
                end
            end
            COUNT: begin
                counter <= counter + 1;
                if (counter >= (delay + 1) * 250) begin
                    counter <= 0;
                    delay <= delay - 1;
                    if (delay == 0) begin
                        state <= NOTIFY;
                        counting <= 0;
                        done <= 1;
                    end
                end
            end
            NOTIFY: begin
                if (ack) begin
                    state <= IDLE;
                    done <= 0;
                end
            end
        endcase
    end
end

assign count = delay;

endmodule
