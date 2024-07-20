module top_module(
	input clk,
	input reset,
	output reg [31:0] q);
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 32'h1;
		end else begin
			q <= {q[30:0], q[29] ^ q[21] ^ q[1] ^ q[0]};
		end
	end
	
	reg [31:0] q_temp;
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q_temp <= 32'h1;
		end else begin
			q_temp <= {q_temp[30:0], q_temp[29] ^ q_temp[21] ^ q_temp[1] ^ q_temp[0]};
		end
	end
	
	
endmodule
