module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

// Define constants for the maximum values of each BCD digit
parameter MAX_ONES   = 4'd9;
parameter MAX_TENS   = 4'd9;
parameter MAX_HUNDREDS = 4'd9;
parameter MAX_THOUSANDS = 4'd9;

// Internal signals to hold the value of each digit
reg [3:0] ones, tens, hundreds, thousands;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        // Reset all digits to 0
        ones <= 0;
        tens <= 0;
        hundreds <= 0;
        thousands <= 0;
    end
    else begin
        // Increment the ones digit
        if (ones == MAX_ONES) begin
            ones <= 0;
            ena[1] = 1'b1; // Ones digit has reached max, enable tens digit
        end
        else begin
            ones <= ones + 1;
            ena[1] = 1'b0;
        end

        // Increment the tens digit
        if (ena[1]) begin
            if (tens == MAX_TENS) begin
                tens <= 0;
                ena[2] = 1'b1; // Tens digit has reached max, enable hundreds digit
            end
            else begin
                tens <= tens + 1;
                ena[2] = 1'b0;
            end
        end

        // Increment the hundreds digit
        if (ena[2]) begin
            if (hundreds == MAX_HUNDREDS) begin
                hundreds <= 0;
                ena[3] = 1'b1; // Hundreds digit has reached max, enable thousands digit
            end
            else begin
                hundreds <= hundreds + 1;
                ena[3] = 1'b0;
            end
        end

        // Increment the thousands digit
        if (ena[3]) begin
            if (thousands == MAX_THOUSANDS) begin
                thousands <= 0;
            end
            else begin
                thousands <= thousands + 1;
            end
        end
    end

    // Combine the digits into the 16-bit output
    q = {thousands, hundreds, tens, ones};
end

endmodule
