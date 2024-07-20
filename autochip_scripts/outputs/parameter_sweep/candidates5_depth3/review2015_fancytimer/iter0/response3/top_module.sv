module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] state;

    reg [3:0] count_reg;
    reg [3:0] remaining_time;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counting <= 0;
            done <= 0;
            delay <= 0;
            state <= 0;
            count_reg <= 0;
            remaining_time <= 0;
        end else begin
            case (state)
                4'b0000: begin // Waiting for start sequence (1101)
                    if (data == 4'b1101) begin
                        delay <= data;
                        state <= 4'b0001;
                    end
                end
                4'b0001: begin // Shifting in 4 more bits for delay
                    delay <= {delay[2:0], data};
                    counting <= 1;
                    state <= 4'b0010;
                end
                4'b0010: begin // Counting for (delay[3:0] + 1) * 1000 clock cycles
                    if (count_reg == 4'b1111) begin
                        done <= 1;
                        counting <= 0;
                        state <= 4'b0011;
                    end else begin
                        count_reg <= count_reg + 1;
                    end
                end
                4'b0011: begin // Waiting for ack before resetting
                    if (ack) begin
                        state <= 4'b0000;
                    end
                end
                default: begin // Should not be reached
                    counting <= 0;
                    done <= 0;
                    delay <= 0;
                    state <= 0;
                    count_reg <= 0;
                    remaining_time <= 0;
                end
            endcase

            if (counting) begin
                count <= count_reg;
                remaining_time <= delay - count_reg;
            end else begin
                count <= 0;
                remaining_time <= delay;
            end
        end
    end

endmodule
