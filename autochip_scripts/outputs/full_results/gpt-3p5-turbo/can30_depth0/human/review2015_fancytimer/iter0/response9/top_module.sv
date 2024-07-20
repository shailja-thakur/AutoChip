module top_module(
    input wire clk,
    input wire reset,
    input wire data,
    output wire [3:0] count,
    output reg counting,
    output reg done,
    input wire ack
);

reg [3:0] delay;
reg [3:0] delay_count;
reg [3:0] timer_count;
reg [1:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 2'b00;
        counting <= 0;
        done <= 0;
        count <= 4'b1111;
        delay <= 4'b0000;
        delay_count <= 4'b0000;
        timer_count <= 4'b0000;
    end else begin
        case (state)
            2'b00: begin
                if (data == 1'b1)
                    state <= 2'b01;
                else
                    state <= 2'b00;
            end
            2'b01: begin
                if (data == 1'b1)
                    state <= 2'b10;
                else
                    state <= 2'b00;
            end
            2'b10: begin
                if (data == 1'b0) begin
                    delay_count <= delay_count + 1;
                    if (delay_count == 4'b1111) begin
                        delay <= data;
                        state <= 2'b11;
                    end
                end else begin
                    delay_count <= 0;
                end
                state <= 2'b10;
            end
            2'b11: begin
                if (counting) begin
                    timer_count <= timer_count + 1;
                    if (timer_count == (delay + 1) * 1000) begin
                        counting <= 0;
                        done <= 1;
                    end
                end else begin
                    if (ack == 1'b1) begin
                        counting <= 1;
                        done <= 0;
                        timer_count <= 0;
                    end
                end
            end
        endcase
    end
end

assign count = counting ? (delay - timer_count / 1000) : 4'bxxxx;

endmodule
