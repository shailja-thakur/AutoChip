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

enum {WAIT_FOR_START, SHIFT_IN_DELAY, WAIT_FOR_COUNT, NOT_COUNTING} state;
reg [3:0] state_reg;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        counting <= 0;
        done <= 0;
        state_reg <= WAIT_FOR_START;
        delay <= 0;
        count_reg <= 0;
        remaining_time <= 0;
    end else begin
        state_reg <= state;
        
        case(state_reg)
            WAIT_FOR_START: begin
                if (data == 4'b1101) begin
                    state <= SHIFT_IN_DELAY;
                end else begin
                    state <= WAIT_FOR_START;
                end
            end
            
            SHIFT_IN_DELAY: begin
                delay <= data;
                count_reg <= (delay + 1) * 1000;
                remaining_time <= delay;
                counting <= 1;
                state <= WAIT_FOR_COUNT;
            end
            
            WAIT_FOR_COUNT: begin
                if (count_reg == 0) begin
                    counting <= 0;
                    done <= 1;
                    state <= NOT_COUNTING;
                end else begin
                    state <= WAIT_FOR_COUNT;
                    count_reg <= count_reg - 1;
                    if (count_reg % 1000 == 0) begin
                        remaining_time <= remaining_time - 1;
                    end
                end
            end
            
            NOT_COUNTING: begin
                if (ack == 1) begin
                    done <= 0;
                    state <= WAIT_FOR_START;
                end else begin
                    state <= NOT_COUNTING;
                end
            end
        endcase
    end
end

assign count = counting ? remaining_time : 4'bxxxx;

endmodule
