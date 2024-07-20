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
reg [3:0] remaining_time;
reg reset_ack;

// State Definitions
parameter IDLE = 2'b00;
parameter READ_DELAY = 2'b01;
parameter COUNT = 2'b10;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        count_reg <= 0;
        delay <= 0;
        remaining_time <= 0;
        reset_ack <= 1;
    end else if (reset_ack) begin
        state <= IDLE;
        counting <= 0;
        done <= 0;
        count_reg <= 0;
        delay <= 0;
        remaining_time <= 0;
        reset_ack <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (data == 4'b1101) begin
                    state <= READ_DELAY;
                    counting <= 0;
                    done <= 0;
                end else begin
                    state <= IDLE;
                end
            end
            READ_DELAY: begin
                state <= COUNT;
                counting <= 1;
                delay <= data;
                count_reg <= (data + 1);
                remaining_time <= (data + 1);
            end
            COUNT: begin
                if (count_reg > 0) begin
                    state <= COUNT;
                    counting <= 1;
                    count_reg <= count_reg - 1;
                    remaining_time <= remaining_time - 1;
                end else begin
                    state <= IDLE;
                    counting <= 0;
                    done <= 1;
                end
            end
        endcase
    end
end

// Output Assignment
assign count = (counting && (state == COUNT)) ? remaining_time[3:0] : 4'bxxxx;

endmodule
