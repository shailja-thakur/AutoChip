module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output reg q
);
	
	always @(b or c) begin
		q = b | c;
	end

endmodule
