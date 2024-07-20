module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
	
	reg [3:0] D;
	
	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			D <= 4'b0;
		end else begin
			D <= {D[2:0], in};
		end
	end
	
	assign out = D[3];
	
endmodule
