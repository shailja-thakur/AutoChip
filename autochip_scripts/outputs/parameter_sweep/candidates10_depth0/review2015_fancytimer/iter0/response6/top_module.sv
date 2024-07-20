module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

reg [3:0] delay;
reg [3:0] counter;
reg [3:0] remaining_time;
reg start;
reg [3:0] state;

parameter IDLE = 0;
parameter DETECT_PATTERN = 1;
parameter SHIFT_IN_DATA = 2;
parameter COUNT = 3;
parameter TIMING_OUT = 4;

always @(posedge clk) begin
    if (reset) begin
        counting <= 0;
        done <= 0;
        state <= IDLE;
        counter <= 0;
        remaining_time <= 0;
        start <= 0;
    end else begin
        case (state)
            IDLE:
                if (data == 4'b1101) begin
                    state <= DETECT_PATTERN;
                    start <= 1;
                end else begin
                    counting <= 0;
                    done <= 0;
                    start <= 0;
                end
            DETECT_PATTERN:
                if (start) begin
                    state <= SHIFT_IN_DATA;
                end
            SHIFT_IN_DATA:
                if (!start && ack) begin
                    delay <= data;
                    state <= COUNT;
                    counting <= 1;
                    start <= 0;
                end
            COUNT:
                if (counter >= (delay + 1)*1000 - 1) begin
                    counting <= 0;
                    done <= 1;
                    state <= TIMING_OUT;
                    remaining_time <= 0;
                end else if (counter >= delay*1000 - 1) begin
                    remaining_time <= delay - 1;
                end else if (counter >= (delay - remaining_time)*1000 - 1) begin
                    remaining_time <= remaining_time - 1;
                end else begin
                    remaining_time <= delay;
                end
            TIMING_OUT:
                if (ack) begin
                    state <= IDLE;
                    counting <= 0;
                    done <= 0;
                    counter <= 0;
                    start <= 0;
                end
        endcase
        if (counting) begin
            counter <= counter + 1;
        end else begin
            counter <= 0;
        end
    end
end

assign count = counter;
endmodule
