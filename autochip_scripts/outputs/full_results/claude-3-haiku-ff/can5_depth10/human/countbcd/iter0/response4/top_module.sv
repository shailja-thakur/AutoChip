module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

localparam BCD_ONES = 4'd0;
localparam BCD_TENS = 4'd4;
localparam BCD_HUNDREDS = 4'd8;
localparam BCD_THOUSANDS = 4'd12;

always @(posedge clk) begin
    if (reset) begin
        q <= 16'b0;
    end
    else begin
        // Increment the ones digit
        q[3:0] <= (q[3:0] == 4'd9) ? BCD_ONES : q[3:0] + 1'b1;

        // Enable the tens, hundreds, and thousands digits
        ena[1] <= (q[3:0] == 4'd9);
        ena[2] <= (q[7:4] == 4'd9 & ena[1]);
        ena[3] <= (q[11:8] == 4'd9 & ena[2]);

        // Increment the tens, hundreds, and thousands digits
        q[7:4] <= (q[7:4] == 4'd9 & ena[1]) ? BCD_TENS : (ena[1]) ? q[7:4] + 1'b1 : q[7:4];
        q[11:8] <= (q[11:8] == 4'd9 & ena[2]) ? BCD_HUNDREDS : (ena[2]) ? q[11:8] + 1'b1 : q[11:8];
        q[15:12] <= (q[15:12] == 4'd9 & ena[3]) ? BCD_THOUSANDS : (ena[3]) ? q[15:12] + 1'b1 : q[15:12];
    end
end

endmodule
