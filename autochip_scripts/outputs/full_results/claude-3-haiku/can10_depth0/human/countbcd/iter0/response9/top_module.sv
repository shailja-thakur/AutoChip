module top_module(
    input clk,
    input reset,
    output [3:1] ena,
    output reg [15:0] q
);

reg [3:0] ones, tens, hundreds, thousands;

always @(posedge clk) begin
    if (reset) begin
        ones <= 4'b0;
        tens <= 4'b0;
        hundreds <= 4'b0;
        thousands <= 4'b0;
        q <= 16'b0;
    end
    else begin
        // Increment ones digit
        ones <= (ones == 9) ? 4'b0 : ones + 1'b1;
        
        // Increment tens digit when ones digit reaches 10
        if (ones == 9) begin
            tens <= (tens == 9) ? 4'b0 : tens + 1'b1;
            ena[1] = 1'b1;
        end
        else begin
            ena[1] = 1'b0;
        end
        
        // Increment hundreds digit when tens digit reaches 10
        if (tens == 9) begin
            hundreds <= (hundreds == 9) ? 4'b0 : hundreds + 1'b1;
            ena[2] = 1'b1;
        end
        else begin
            ena[2] = 1'b0;
        end
        
        // Increment thousands digit when hundreds digit reaches 10
        if (hundreds == 9) begin
            thousands <= (thousands == 9) ? 4'b0 : thousands + 1'b1;
            ena[3] = 1'b1;
        end
        else begin
            ena[3] = 1'b0;
        end
        
        // Construct the 16-bit output
        q = {thousands, hundreds, tens, ones};
    end
end

endmodule
