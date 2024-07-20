module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

reg [3:0] ones, tens, hundreds, thousands;

always @(posedge clk) begin
    if (reset) begin
        ones <= 0;
        tens <= 0;
        hundreds <= 0;
        thousands <= 0;
        q <= 0;
    end
    else begin
        // Increment ones digit
        if (ones == 9) begin
            ones <= 0;
            ena[1] = 1'b1; // Increment tens digit
        end
        else begin
            ones <= ones + 1;
            ena[1] = 1'b0;
        end

        // Increment tens digit
        if (tens == 9 && ena[1]) begin
            tens <= 0;
            ena[2] = 1'b1; // Increment hundreds digit
        end
        else begin
            tens <= tens + ena[1];
            ena[2] = 1'b0;
        end

        // Increment hundreds digit
        if (hundreds == 9 && ena[2]) begin
            hundreds <= 0;
            ena[3] = 1'b1; // Increment thousands digit
        end
        else begin
            hundreds <= hundreds + ena[2];
            ena[3] = 1'b0;
        end

        // Increment thousands digit
        if (thousands == 9 && ena[3]) begin
            thousands <= 0;
        end
        else begin
            thousands <= thousands + ena[3];
        end

        // Assemble the 16-bit output
        q <= {thousands, hundreds, tens, ones};
    end
end

endmodule
