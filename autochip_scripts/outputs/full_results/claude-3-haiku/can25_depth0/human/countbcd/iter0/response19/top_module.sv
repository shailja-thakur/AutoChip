module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

// Declare internal signals for the individual digits
reg [3:0] ones, tens, hundreds, thousands;

always @(posedge clk) begin
    if (reset) begin
        // Reset all digits to 0
        ones <= 0;
        tens <= 0;
        hundreds <= 0;
        thousands <= 0;
    end
    else begin
        // Increment the ones digit
        ones <= (ones == 9) ? 0 : ones + 1;

        // Increment the tens, hundreds, and thousands digits when the lower digit rolls over
        if (ones == 0) begin
            tens <= (tens == 9) ? 0 : tens + 1;
            ena[1] = (tens == 0);
        end
        if (tens == 0) begin
            hundreds <= (hundreds == 9) ? 0 : hundreds + 1;
            ena[2] = (hundreds == 0);
        end
        if (hundreds == 0) begin
            thousands <= (thousands == 9) ? 0 : thousands + 1;
            ena[3] = (thousands == 0);
        end
    end

    // Pack the digits into the 16-bit output
    q <= {thousands, hundreds, tens, ones};
end

endmodule
