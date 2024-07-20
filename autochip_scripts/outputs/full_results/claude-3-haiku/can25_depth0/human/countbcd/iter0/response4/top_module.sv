module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

reg [3:0] ones, tens, hundreds, thousands;

always @(posedge clk) begin
    if (reset) begin
        ones <= 4'b0000;
        tens <= 4'b0000;
        hundreds <= 4'b0000;
        thousands <= 4'b0000;
    end
    else begin
        // Increment the ones digit
        if (ones == 4'b1001) begin
            ones <= 4'b0000;
            ena[1] = 1'b1; // Enable the tens digit
        end
        else begin
            ones <= ones + 1'b1;
            ena[1] = 1'b0;
        end

        // Increment the tens digit
        if (ena[1] && tens == 4'b1001) begin
            tens <= 4'b0000;
            ena[2] = 1'b1; // Enable the hundreds digit
        end
        else if (ena[1]) begin
            tens <= tens + 1'b1;
            ena[2] = 1'b0;
        end

        // Increment the hundreds digit
        if (ena[2] && hundreds == 4'b1001) begin
            hundreds <= 4'b0000;
            ena[3] = 1'b1; // Enable the thousands digit
        end
        else if (ena[2]) begin
            hundreds <= hundreds + 1'b1;
            ena[3] = 1'b0;
        end

        // Increment the thousands digit
        if (ena[3] && thousands == 4'b1001) begin
            thousands <= 4'b0000;
        end
        else if (ena[3]) begin
            thousands <= thousands + 1'b1;
        end
    end

    // Assemble the 16-bit value
    q = {thousands, hundreds, tens, ones};
end

endmodule
