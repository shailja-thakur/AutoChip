module top_module(
	input wire clk,
	input wire reset,
	input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] count_reg;
    reg [1:0] state;

    always @(posedge clk) begin
        if (reset) begin
            counting <= 0;
            done <= 0;
            state <= 0;
            count_reg <= 0;
            delay <= 0;
        end else begin
            case (state)
                0: begin
                    if (data == 4'b1101) begin
                        state <= 1;
                    end
                end

                1: begin
                    delay[3] <= data;
                    state <= 2;
                end

                2: begin
                    delay[2] <= data;
                    state <= 3;
                end

                3: begin
                    delay[1] <= data;
                    state <= 4;
                end

                4: begin
                    delay[0] <= data;
                    state <= 5;
                end

                5: begin
                    counting <= 1;
                    count_reg <= (delay + 1) * 1000;
                    state <= 6;
                end

                6: begin
                    if (count_reg > 0) begin
                        count_reg <= count_reg - 1;
                    end else begin
                        counting <= 0;
                        done <= 1;
                        state <= 7;
                    end
                end

                7: begin
                    if (ack) begin
                        state <= 0;
                        done <= 0;
                    end
                end
            endcase
        end
    end

    assign count = counting ? count_reg[3:0] : 4'bzzzz;
endmodule
