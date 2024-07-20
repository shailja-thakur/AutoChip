module top_module (
	input clk,
	input in,
	output reg out
);
    
    // Initialize output to 0
    initial out = 0;
    
    always @(posedge clk) begin
        out <= in ^ out;  // Toggle the output based on the input and previous output
    end
    
endmodule
