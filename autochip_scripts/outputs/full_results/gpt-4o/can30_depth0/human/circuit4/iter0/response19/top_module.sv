module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output reg q
);

always @(*) begin
    q = (b & c) | (a & c);
end

endmodule
