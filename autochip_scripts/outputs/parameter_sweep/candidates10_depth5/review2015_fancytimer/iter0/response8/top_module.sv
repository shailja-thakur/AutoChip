module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

parameter [3:0] START_PATTERN = 4'b1101;

reg [3:0] delay;
reg [3:0] count_max;
reg [3:0] remaining;
reg [2:0] state;
reg found_start;

always @(posedge clk) begin
    if (reset) begin
        state <= 0;
        count <= 0;
        counting <= 0;
        done <= 0;
    end else begin
        case (state)
            0: begin
                if (data == START_PATTERN) begin
                    state <= 1;
                    found_start <= 1;
                    counting <= 1;
                end else begin
                    state <= 0;
                    found_start <= 0;
                    counting <= 0;
                end
                count <= 0;
            end
            1: begin
                delay <= data;
                count_max <= (delay + 1) * 1000;
                remaining <= delay;
                state <= 2;
            end
            2: begin
                if (count == count_max) begin
                    if (remaining == 0) begin
                        state <= 3;
                        done <= 1;
                        counting <= 0;
                    end else begin
                        remaining <= remaining - 1;
                        count <= 0;
                    end
                end else begin
                    count <= count + 1;
                end
            end
            3: begin
                if (ack) begin
                    state <= 0;
                    done <= 0;
                end
            end
            default: state <= 0;
        endcase
    end
end

endmodule
