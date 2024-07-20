module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

	always @(posedge clock) begin
		case ({q, p, a})
			3'b000: begin
				p <= 1'b0;
				q <= 1'b0;
			end
			3'b001: begin
				p <= 1'b1;
				q <= 1'b0;
			end
			3'b010: begin
				p <= 1'b1;
				q <= 1'b0;
			end
			3'b011: begin
				p <= 1'b0;
				q <= 1'b1;
			end
			3'b100: begin
				p <= 1'b1;
				q <= 1'b1;
			end
			default: begin
				p <= 1'b0;
				q <= 1'b0;
			end
		endcase
	end
endmodule
