module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

reg [3:0] ones_digit;
reg [3:0] tens_digit;
reg [3:0] hundreds_digit;
reg [3:0] thousands_digit;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 0;
        ones_digit <= 0;
        tens_digit <= 0;
        hundreds_digit <= 0;
        thousands_digit <= 0;
    end else begin
        q <= {thousands_digit, hundreds_digit, tens_digit[3:0], ones_digit[3:0]};
        ones_digit <= (ena[0]) ? (ones_digit + 1) : ones_digit;
        tens_digit <= (ena[1]) ? (tens_digit + (ones_digit == 9)) : tens_digit;
        hundreds_digit <= (ena[2]) ? (hundreds_digit + (tens_digit == 9 && ones_digit == 9)) : hundreds_digit;
        thousands_digit <= (tens_digit == 9 && ones_digit == 9 && hundreds_digit == 9) ? (thousands_digit + 1) : thousands_digit;
    end
end

endmodule
