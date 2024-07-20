module top_module (
	input wire clock,
	input wire a, 
	output reg p,
	output reg q
);

reg state;

always @(posedge clock) begin
	if (a == 1'b0) begin
		state <= 1'b0;
	end else begin
		state <= 1'b1;
	end
end

always @(posedge clock) begin
	case (state)
		1'b0: begin
			p <= 1'b0;
			q <= 1'b0;
		end
		1'b1: begin
			p <= 1'b1;
			q <= 1'b1;
		end
	endcase
end

endmodule
