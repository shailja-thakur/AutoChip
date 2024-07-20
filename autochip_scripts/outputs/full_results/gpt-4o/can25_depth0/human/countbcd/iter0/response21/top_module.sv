module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q);

    wire [3:0] ones, tens, hundreds, thousands;
    wire ena_one, ena_ten, ena_hundred;

    assign ones = q[3:0];
    assign tens = q[7:4];
    assign hundreds = q[11:8];
    assign thousands = q[15:12];

    assign ena[1] = ena_one;
    assign ena[2] = ena_ten;
    assign ena[3] = ena_hundred;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 16'd0;
        end else begin
            if (ones == 4'd9) begin
                q[3:0] <= 4'd0;
                ena_one <= 1'b1;
            end else begin
                q[3:0] <= ones + 1;
                ena_one <= 1'b0;
            end

            if (ena_one && tens == 4'd9) begin
                q[7:4] <= 4'd0;
                ena_ten <= 1'b1;
            end else if (ena_one) begin
                q[7:4] <= tens + 1;
                ena_ten <= 1'b0;
            end

            if (ena_ten && hundreds == 4'd9) begin
                q[11:8] <= 4'd0;
                ena_hundred <= 1'b1;
            end else if (ena_ten) begin
                q[11:8] <= hundreds + 1;
                ena_hundred <= 1'b0;
            end

            if (ena_hundred && thousands == 4'd9) begin
                q[15:12] <= 4'd0;
            end else if (ena_hundred) begin
                q[15:12] <= thousands + 1;
            end
        end
    end
endmodule
