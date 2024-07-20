module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

// Define the decimal digits
integer ones = 0, tens = 0, hundreds = 0, thousands = 0;

always @(posedge clk) begin
    if (reset) begin
        ones <= 0;
        tens <= 0;
        hundreds <= 0;
        thousands <= 0;
        q <= 0;
    end
    else begin
        // Increment the ones digit
        ones <= (ones == 9) ? 0 : ones + 1;
        
        // Increment the tens digit
        if (ones == 9) begin
            tens <= (tens == 9) ? 0 : tens + 1;
            ena[1] = 1; // Tens digit is enabled
        end
        else begin
            ena[1] = 0;
        end
        
        // Increment the hundreds digit
        if (tens == 9 && ones == 9) begin
            hundreds <= (hundreds == 9) ? 0 : hundreds + 1;
            ena[2] = 1; // Hundreds digit is enabled
        end
        else begin
            ena[2] = 0;
        end
        
        // Increment the thousands digit
        if (hundreds == 9 && tens == 9 && ones == 9) begin
            thousands <= (thousands == 9) ? 0 : thousands + 1;
            ena[3] = 1; // Thousands digit is enabled
        end
        else begin
            ena[3] = 0;
        end
        
        // Assign the output
        q[3:0] <= ones;
        q[7:4] <= tens;
        q[11:8] <= hundreds;
        q[15:12] <= thousands;
    end
end

endmodule
