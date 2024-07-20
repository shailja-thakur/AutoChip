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
        // Increment the ones digit
        ones <= (ones == 4'd9) ? 4'b0 : ones + 4'b1;
        
        // Increment the tens digit when the ones digit rolls over
        if (ones == 4'd0) begin
            tens <= (tens == 4'd9) ? 4'b0 : tens + 4'b1;
            ena[1] = 1'b1;
        end
        else begin
            ena[1] = 1'b0;
        end
        
        // Increment the hundreds digit when the tens digit rolls over
        if (tens == 4'd0) begin
            hundreds <= (hundreds == 4'd9) ? 4'b0 : hundreds + 4'b1;
            ena[2] = 1'b1;
        end
        else begin
            ena[2] = 1'b0;
        end
        
        // Increment the thousands digit when the hundreds digit rolls over
        if (hundreds == 4'd0) begin
            thousands <= (thousands == 4'd9) ? 4'b0 : thousands + 4'b1;
            ena[3] = 1'b1;
        end
        else begin
            ena[3] = 1'b0;
        end
        
        // Assemble the 16-bit output
        q <= {thousands, hundreds, tens, ones};
    end
end

endmodule
