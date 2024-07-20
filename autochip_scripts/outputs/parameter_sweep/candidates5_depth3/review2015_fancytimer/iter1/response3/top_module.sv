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
reg [3:0] count_next;
reg [1:0] state;
reg [3:0] remaining_time;

wire [3:0] count_internal;
reg [31:0] count_cycle;

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
        count_cycle <= 0;
    end else begin
        case (state)
            IDLE: begin
                if (data == 4'b1101) begin
                    state <= READ_DELAY;
                    counting <= 0;
                    done <= 0;
                    count_cycle <= 0;
                end else begin
                    state <= IDLE;
                end
            end
            READ_DELAY: begin
                state <= COUNT;
                counting <= 1;
                count_reg <= data;
                delay <= data;
                count_cycle <= (data + 1) * 1000;
                remaining_time <= data;
                count_next <= data - 1;
            end
            COUNT: begin
                if (count_cycle > 0) begin
                    state <= COUNT;
                    counting <= 1;
                    count_cycle <= count_cycle - 1;
                    if (count_next == 0) begin
                        count_next <= delay;
                        remaining_time <= delay;
                    end else begin
                        count_next <= count_next - 1;
                        remaining_time <= remaining_time - 1;
                    end
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
assign count_internal = counting ? count_next : 4'bxxxx;

always @(posedge clk) begin
    if (reset) begin
        count_reg <= 0;
    end else begin
        count_reg <= count_internal;
    end
end

assign count = counting ? count_reg : 4'bxxxx;

endmodule
