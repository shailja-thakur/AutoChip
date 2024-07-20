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
reg [3:0] counter;

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
        counter <= 0;
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
                count_reg <= data;
                remaining_time <= data;
                counter <= 0;
            end
            COUNT: begin
                if (counter < ((delay + 1) * 1000) - 1) begin
                    state <= COUNT;
                    counting <= 1;
                    count_reg <= delay;
                    remaining_time <= delay - (counter / 1000);
                    counter <= counter + 1;
                end else begin
                    state <= IDLE;
                    counting <= 0;
                    done <= 1;
                    count_reg <= 0;
                    remaining_time <= 0;
                    counter <= 0;
                end
            end
        endcase
    end
end

// Output Assignment
assign count = counting ? remaining_time : 4'bxxxx;

endmodule
