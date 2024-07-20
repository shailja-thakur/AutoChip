module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
	reg [3:0] d;
	assign out = d[0];
	
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			d <= 4'b0;
		end else begin
			d <= {d[2:0], in};
		end
	end	
endmodule
