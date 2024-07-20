module top_module(
	input clk,
	input resetn,
	input [1:0] byteena,
	input [15:0] d,
	output reg [15:0] q);
	
	reg [7:0] d_low;
	reg [7:0] d_high;
	reg [7:0] q_low;
	reg [7:0] q_high;
	
	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			d_low <= 8'b0;
			d_high <= 8'b0;
			q_low <= 8'b0;
			q_high <= 8'b0;
		end else begin
			if (byteena[0]) begin
				d_low <= d[7:0];
				q_low <= q[7:0];
			end
			if (byteena[1]) begin
				d_high <= d[15:8];
				q_high <= q[15:8];
			end
		end
	end
	
	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			q <= 16'b0;
		end else begin
			q <= {q_high, q_low};
		end
	end

endmodule
