module top_module(
	input clk,
	input areset,
	input load,
	input ena,
	input [3:0] data,
	output reg [3:0] q);

	reg [3:0] q_next;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			q_next <= 0;
		end else if (load) begin
			q_next <= data;
		end else if (ena) begin
			q_next <= {q[2:0], q[3]};
		end else begin
			q_next <= q_next; // Change from q_next <= q to q_next <= q_next
		end
	end
	
	always @(posedge clk) begin
		q <= q_next;
	end
	
endmodule
