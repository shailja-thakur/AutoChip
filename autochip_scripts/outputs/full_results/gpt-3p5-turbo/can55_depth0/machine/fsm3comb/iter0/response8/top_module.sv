module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

	always_comb begin
		case (state)
			2'b00: 
				if (in) begin
					next_state = 2'b01;
				end else begin
					next_state = 2'b00;
				end
			2'b01: 
				if (in) begin
					next_state = 2'b01;
				end else begin
					next_state = 2'b10;
				end
			2'b10:
				if (in) begin
					next_state = 2'b11;
				end else begin
					next_state = 2'b00;
				end
			2'b11:
				if (in) begin
					next_state = 2'b01;
				end else begin
					next_state = 2'b10;
				end
		endcase
	end

	assign out = (state == 2'b11);

endmodule
