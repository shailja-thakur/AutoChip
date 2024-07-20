module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output reg out
);

always_comb begin
	case(state)
		2'b00: begin // state A
			if(in) begin
				next_state = 2'b01; // state B
			end
			else begin
				next_state = 2'b00; // state A
			end
		end

		2'b01: begin // state B
			if(in) begin
				next_state = 2'b01; // state B
			end
			else begin
				next_state = 2'b10; // state C
			end
		end

		2'b10: begin // state C
			if(in) begin
				next_state = 2'b11; // state D
			end
			else begin
				next_state = 2'b00; // state A
			end
		end

		2'b11: begin // state D
			if(in) begin
				next_state = 2'b01; // state B
			end
			else begin
				next_state = 2'b10; // state C
			end
		end
	endcase

	if(state == 2'b11) begin // state D
		out = 1'b1; // high
	end
	else begin
		out = 1'b0; // low
	end
end

endmodule
