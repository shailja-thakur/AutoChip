module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);

reg out;

always @(*) begin
	if (~a & ~b & ~c & d) begin
		out = 1;
	end else if (~a & ~b & c & d) begin
		out = 1;
	end else if (a & ~b & ~c & d) begin
		out = 0;
	end else if (~a & b & c & d) begin
		out = 0;
	end else if (~a & b & ~c & ~d) begin
		out = 1;
	end else if (a & b & ~c & ~d) begin
		out = 1;
	end else if (~a & ~b & c & ~d) begin
		out = 0;
	end else if (a & ~b & c & ~d) begin
		out = 0;
	end else if (a & b & c & ~d) begin
		out = 1;
	end else if (a & b & c & d) begin
		out = 1;
	end else begin
		out = 0;
	end
end

endmodule
