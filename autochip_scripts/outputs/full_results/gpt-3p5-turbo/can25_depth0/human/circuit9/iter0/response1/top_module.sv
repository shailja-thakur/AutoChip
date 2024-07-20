module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

always @(posedge clk) begin
	// Add your code here
	if (a == 1) begin
		case(q)
			0: q <= 1;
			1: q <= 2;
			2: q <= 3;
			3: q <= 4;
			default: q <= 0;
		endcase
	end else begin
		case(q)
			0: q <= 0;
			1: q <= 0;
			2: q <= 0;
			3: q <= 0;
			default: q <= 0;
		endcase
	end
end

endmodule
