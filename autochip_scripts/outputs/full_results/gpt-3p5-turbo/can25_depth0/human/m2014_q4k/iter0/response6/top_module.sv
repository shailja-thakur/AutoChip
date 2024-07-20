module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
	
	reg [3:0] d;
	wire q0, q1, q2, q3;
	
	always @(posedge clk or negedge resetn)
	begin
		if (~resetn)
			d <= 4'b0000;
		else
			d <= {in, d[3:1]};
	end
	
	assign q0 = d[0];
	assign q1 = d[1];
	assign q2 = d[2];
	assign q3 = d[3];
	
	assign out = q0;
	
endmodule
