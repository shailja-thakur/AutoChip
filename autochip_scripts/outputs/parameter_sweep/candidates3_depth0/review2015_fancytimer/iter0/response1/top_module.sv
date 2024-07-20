module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

reg [3:0] delay;
reg [3:0] count;
reg [7:0] shift_reg;
reg start_detected;
reg [3:0] timer_value;

parameter [3:0] START_PATTERN = 4'b1101;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        shift_reg <= 0;
        start_detected <= 0;
        counting <= 0;
        done <= 0;
        timer_value <= 0;
        count <= 0;
    end else begin
        if (start_detected) begin
            if (counting) begin
                if (count == 0) begin
                    counting <= 0;
                    done <= 1;
                    if (ack) begin
                        start_detected <= 0;
                        counting <= 0;
                        done <= 0;
                        timer_value <= 0;
                        count <= 0;
                    end
                end else begin
                    count <= count - 1;
                end
            end else begin
                if (ack) begin
                    shift_reg <= 0;
                    start_detected <= 0;
                    counting <= 0;
                    done <= 0;
                    timer_value <= 0;
                    count <= 0;
                end
            end
        end else begin
            if (data == START_PATTERN) begin
                start_detected <= 1;
                shift_reg <= 0;
            end else begin
                shift_reg <= {shift_reg[6:0], data};
            end
        end

        if (start_detected && ~counting) begin
            case (shift_reg[7:4])
                0: begin
                    timer_value <= 0;
                end
                1: begin
                    timer_value <= 1;
                end
                2: begin
                    timer_value <= 2;
                end
                3: begin
                    timer_value <= 3;
                end
                4: begin
                    timer_value <= 4;
                end
                5: begin
                    timer_value <= 5;
                end
                6: begin
                    timer_value <= 6;
                end
                7: begin
                    timer_value <= 7;
                end
                8: begin
                    timer_value <= 8;
                end
                9: begin
                    timer_value <= 9;
                end
                10: begin
                    timer_value <= 10;
                end
                11: begin
                    timer_value <= 11;
                end
                12: begin
                    timer_value <= 12;
                end
                13: begin
                    timer_value <= 13;
                end
                14: begin
                    timer_value <= 14;
                end
                15: begin
                    timer_value <= 15;
                end
                default: begin
                    timer_value <= 0;
                end
            end

            counting <= 1;
            count <= (timer_value + 1) * 1000;

            if (count == 0) begin
                counting <= 0;
                done <= 1;
            end
        end
    end
end

endmodule
