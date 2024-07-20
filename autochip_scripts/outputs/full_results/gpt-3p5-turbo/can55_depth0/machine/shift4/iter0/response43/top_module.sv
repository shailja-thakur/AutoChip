module top_module(
	input clk,
	input areset,
	input load,
	input ena,
	input [3:0] data,
	output reg [3:0] q);
	
	// internal wires and registers
	reg [3:0] q_next;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			q_next <= 4'b0;
		end else begin
			if (load) begin
				q_next <= data;
			end else if (ena) begin
				q_next <= {q[2:0], q[3]};
			end else begin
				q_next <= q;
			end
		end
	end
	
	// assign the output
	assign q = q_next;
	
endmodule
