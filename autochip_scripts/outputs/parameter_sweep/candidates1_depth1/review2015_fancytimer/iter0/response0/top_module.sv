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
    reg start;
    reg [3:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counting <= 0;
            done <= 0;
            start <= 0;
            delay <= 0;
            count_reg <= 0;
            remaining_time <= 0;
            state <= 0;
        end else begin
            start <= (state == 0 && data == 1 && #(delay + 1) * 1000);
            counting <= (state == 1 && remaining_time > 0);
            done <= (state == 1 && remaining_time == 0 && ack == 1);

            if (start) begin
                count_reg <= #(delay + 1) * 1000;
                remaining_time <= delay + 1;
                state <= 1;
            end else if (counting) begin
                count_reg <= count_reg - 1;
                remaining_time <= remaining_time - (count_reg == 0);
                state <= (remaining_time > 0) ? 1 : 2;
            end else if (done) begin
                state <= 2;
            end else begin
                state <= 0;
            end
        end
    end

    always @(posedge clk) begin
        count <= counting ? remaining_time : 4'b0;
    end

endmodule
