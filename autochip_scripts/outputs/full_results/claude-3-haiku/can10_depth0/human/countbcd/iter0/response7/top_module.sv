module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

localparam MAX_DIGIT = 9;

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
        if (ones == MAX_DIGIT) begin
            ones <= 0;
            ena[1] = 1'b1;
        end
        else begin
            ones <= ones + 1;
            ena[1] = 1'b0;
        end

        // Increment tens digit
        if (ena[1] && tens == MAX_DIGIT) begin
            tens <= 0;
            ena[2] = 1'b1;
        end
        else if (ena[1]) begin
            tens <= tens + 1;
            ena[2] = 1'b0;
        end

        // Increment hundreds digit
        if (ena[2] && hundreds == MAX_DIGIT) begin
            hundreds <= 0;
            ena[3] = 1'b1;
        end
        else if (ena[2]) begin
            hundreds <= hundreds + 1;
            ena[3] = 1'b0;
        end

        // Increment thousands digit
        if (ena[3] && thousands == MAX_DIGIT) begin
            thousands <= 0;
        end
        else if (ena[3]) begin
            thousands <= thousands + 1;
        end

        // Combine digits into 16-bit output
        q <= {thousands, hundreds, tens, ones};
    end
end

endmodule
