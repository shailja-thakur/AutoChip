module top_module (
	input clk,
	input a, 
	output reg [2:0] q
);

	always @(posedge clk) begin
		case ({a, q})
			2'b10: q <= 3'b100; // When a is 1, q is set to 4.
			2'b01: begin // When a is 0 and q is 6, q is set to 0.
				if (q == 3'b110)
					q <= 3'b000;
				else
					q <= q + 1;
			end
			default: q <= q; // When a is 0 and q is not 6, q is increased by 1.
		endcase
	end

endmodule
