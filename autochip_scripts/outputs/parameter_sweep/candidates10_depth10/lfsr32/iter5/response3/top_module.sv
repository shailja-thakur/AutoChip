module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [31:0] q_temp;

	always @(posedge clk) begin
		if (reset) begin
			q_temp <= 32'h1;
		end else begin
			q_temp <= {q[30:0], q[22]^q[2]^q[1]^q[0]};
		end
	end
	
	always @(posedge clk) begin
		if (reset) begin
			q <= q_temp;
		end
	end
	
endmodule
