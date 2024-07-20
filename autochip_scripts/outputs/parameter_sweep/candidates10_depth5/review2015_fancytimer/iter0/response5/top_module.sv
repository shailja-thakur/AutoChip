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
    reg [3:0] remaining_time;
    reg [3:0] state;
    
    reg [3:0] data_reg;
    reg [3:0] pattern;
    reg shift_in;
    
    parameter WAIT_PATTERN = 4'b1101;
    parameter WAIT_DELAY = 4;
    parameter COUNT_CYCLES = 1000;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 0;
            shift_in <= 0;
            counting <= 0;
            done <= 0;
            count_reg <= 0;
            remaining_time <= 0;
        end else begin
            case(state)
                0: begin
                    if (data == 1 && shift_in == 0) begin
                        shift_in <= 1;
                        pattern <= WAIT_PATTERN;
                        state <= 1;
                    end
                end
                1: begin
                    if (shift_in == 1) begin
                        data_reg <= data;
                        shift_in <= 0;
                        state <= 2;
                    end
                end
                2: begin
                    shift_in <= 1;
                    pattern <= pattern >> 1;
                    if (pattern == 0) begin
                        delay <= data_reg;
                        state <= 3;
                    end
                end
                3: begin
                    counting <= 1;
                    done <= 0;
                    state <= 4;
                    count_reg <= delay + 1;
                    remaining_time <= delay;
                end
                4: begin
                    if (count_reg > 0) begin
                        count_reg <= count_reg - 1;
                        remaining_time <= remaining_time - 1;
                    end else begin
                        counting <= 0;
                        done <= 1;
                        if (ack == 1) begin
                            state <= 0;
                        end
                    end
                end
            endcase
        end
    end
    
    assign count = counting ? remaining_time : 4'bXXXX;

endmodule
