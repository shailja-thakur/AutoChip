module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output reg [3:0] count,
    output reg counting,
    output reg done,
    input wire ack );

    reg [3:0] delay;
    reg [3:0] remaining_time;
    reg [3:0] shift_reg;
    reg [3:0] next_state;
    reg [2:0] state;
    reg start_sequence_detected;
    reg [3:0] count_reg;
   
    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
            count_reg <= 0;
            counting <= 0;
            done <= 0;
            remaining_time <= 0;
            shift_reg <= 0;
            delay <= 0;
            start_sequence_detected <= 0;
            count <= 0;
        end
        else begin
            case(state)
                0: begin
                    if (data) begin
                        shift_reg[3] <= data;
                        shift_reg[2:0] <= shift_reg[3:1];
                        if (shift_reg == 4'b1101) begin
                            start_sequence_detected <= 1;
                            state <= 1;
                        end
                    end
                end
                1: begin
                    if (data) begin
                        shift_reg[3] <= data;
                        shift_reg[2:0] <= shift_reg[3:1];
                        delay <= shift_reg;
                        counting <= 1;
                        state <= 2;
                    end
                end
                2: begin
                    counting <= 1;
                    count_reg <= count_reg + 1;
                    if (count_reg >= (delay + 1)*1000) begin
                        counting <= 0;
                        done <= 1;
                        state <= 3;
                    end
                end
                3: begin
                    if (ack) begin
                        state <= 0;
                        done <= 0;
                    end
                end
            endcase
            count <= remaining_time;
            if (count_reg <= delay*1000) begin
                remaining_time <= delay - count_reg/1000;
            end
            else begin
                remaining_time <= 0;
            end
        end
    end
endmodule
