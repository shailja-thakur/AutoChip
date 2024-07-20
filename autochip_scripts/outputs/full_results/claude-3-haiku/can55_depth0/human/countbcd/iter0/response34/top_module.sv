module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

parameter ONES_BITS = 3:0;
parameter TENS_BITS = 7:4;
parameter HUNDREDS_BITS = 11:8;
parameter THOUSANDS_BITS = 15:12;

always @(posedge clk) begin
    if (reset) begin
        q <= 16'h0000;
    end else begin
        q[ONES_BITS] <= (q[ONES_BITS] == 9) ? 0 : q[ONES_BITS] + 1;
        ena[1] <= (q[ONES_BITS] == 9);
        q[TENS_BITS] <= (q[ONES_BITS] == 9) ? ((q[TENS_BITS] == 9) ? 0 : q[TENS_BITS] + 1) : q[TENS_BITS];
        ena[2] <= (q[ONES_BITS] == 9) && (q[TENS_BITS] == 9);
        q[HUNDREDS_BITS] <= (q[ONES_BITS] == 9) && (q[TENS_BITS] == 9) ? ((q[HUNDREDS_BITS] == 9) ? 0 : q[HUNDREDS_BITS] + 1) : q[HUNDREDS_BITS];
        ena[3] <= (q[ONES_BITS] == 9) && (q[TENS_BITS] == 9) && (q[HUNDREDS_BITS] == 9);
        q[THOUSANDS_BITS] <= (q[ONES_BITS] == 9) && (q[TENS_BITS] == 9) && (q[HUNDREDS_BITS] == 9) ? ((q[THOUSANDS_BITS] == 9) ? 0 : q[THOUSANDS_BITS] + 1) : q[THOUSANDS_BITS];
    end
end

endmodule
