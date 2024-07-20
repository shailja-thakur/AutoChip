module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

// Declare internal variables for the digit counters
reg [3:0] ones, tens, hundreds, thousands;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        ones <= 0;
        tens <= 0;
        hundreds <= 0;
        thousands <= 0;
        q <= 0;
    end
    else begin
        // Increment the ones digit
        if (ones == 4'd9) begin
            ones <= 0;
            ena[1] = 1'b1; // Enable the tens digit
        end
        else begin
            ones <= ones + 1'b1;
            ena[1] = 1'b0;
        end

        // Increment the tens digit
        if (ones == 4'd9 && tens == 4'd9) begin
            tens <= 0;
            ena[2] = 1'b1; // Enable the hundreds digit
        end
        else if (ena[1]) begin
            tens <= tens + 1'b1;
            ena[2] = 1'b0;
        end

        // Increment the hundreds digit
        if (ones == 4'd9 && tens == 4'd9 && hundreds == 4'd9) begin
            hundreds <= 0;
            ena[3] = 1'b1; // Enable the thousands digit
        end
        else if (ena[2]) begin
            hundreds <= hundreds + 1'b1;
            ena[3] = 1'b0;
        end

        // Increment the thousands digit
        if (ones == 4'd9 && tens == 4'd9 && hundreds == 4'd9 && thousands == 4'd9) begin
            thousands <= 0;
        end
        else if (ena[3]) begin
            thousands <= thousands + 1'b1;
        end

        // Update the output q
        q <= {thousands, hundreds, tens, ones};
    end
end

endmodule
