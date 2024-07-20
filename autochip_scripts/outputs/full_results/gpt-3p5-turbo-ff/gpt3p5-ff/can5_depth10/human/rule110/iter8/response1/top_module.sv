module top_module(
	input clk,
	input load,
	input [511:0] data,
	output reg [511:0] q);

	always @(posedge clk) begin
		if (load == 1'b1) begin
			q <= data;
		end else begin
			q[0] <= (q[1] & q[0] & ~q[2]) ? 1'b1 : 1'b0;
			for (int i = 1; i < 511; i = i + 1) begin
				case ({q[i-1], q[i], q[i+1]})
					3'b111: q[i] <= 1'b0;
					3'b110: q[i] <= 1'b1;
					3'b101: q[i] <= 1'b1;
					3'b100: q[i] <= 1'b0;
					3'b011: q[i] <= 1'b1;
					3'b010: q[i] <= 1'b1;
					3'b001: q[i] <= 1'b1;
					3'b000: q[i] <= 1'b0;
				endcase
			end
			q[511] <= (q[510] & q[511] & ~q[510]) ? 1'b1 : 1'b0;
		end
	end

endmodule
