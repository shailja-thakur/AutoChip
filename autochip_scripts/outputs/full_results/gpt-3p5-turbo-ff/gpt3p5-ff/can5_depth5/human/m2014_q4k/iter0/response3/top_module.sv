module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
	
	reg [3:0] d_flops;
	wire [3:0] d_flops_next;
	
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			d_flops <= 4'b0;
		else
			d_flops <= d_flops_next;
	end
	
	assign d_flops_next[0] = in;
	assign d_flops_next[1] = d_flops[0];
	assign d_flops_next[2] = d_flops[1];
	assign d_flops_next[3] = d_flops[2];
	
	assign out = d_flops[3];
	
endmodule
