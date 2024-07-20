module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

	initial begin
		q = 3'bx;
	end

	always @(posedge clk) begin
		if (q === 3'bx) begin
			// Initialize q to 4 at the first clock edge
			q <= 3'b100;
		end else if (a == 1) begin
			q <= 3'b100;
		end else if (q == 3'b100) begin
			q <= 3'b101;
		end else if (q == 3'b101) begin
			q <= 3'b110;
		end else if (q == 3'b110) begin
			q <= 3'b000;
		end else if (q == 3'b000) begin
			q <= 3'b001;
		end
	end

endmodule
