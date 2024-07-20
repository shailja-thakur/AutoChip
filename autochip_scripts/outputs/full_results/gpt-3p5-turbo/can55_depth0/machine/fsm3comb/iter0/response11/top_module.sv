module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output reg out
);

always_comb begin
	// state transition logic
	case (state)
		2'b00: begin // state A
			if (in) begin // transition to state B when in is high
				next_state = 2'b01;
			end else begin // remain in state A when in is low
				next_state = 2'b00;
			end
		end
		2'b01: begin // state B
			if (in) begin // remain in state B when in is high
				next_state = 2'b01;
			end else begin // transition to state C when in is low
				next_state = 2'b10;
			end
		end
		2'b10: begin // state C
			if (in) begin // transition to state D when in is high
				next_state = 2'b11;
			end else begin // transition to state A when in is low
				next_state = 2'b00;
			end
		end
		2'b11: begin // state D
			if (in) begin // transition to state B when in is high
				next_state = 2'b01;
			end else begin // transition to state C when in is low
				next_state = 2'b10;
			end
		end
	endcase
	
	// output logic
	if (state == 2'b11) begin // state D
		out = 1'b1; // out is high when in state D
	else
		out = 1'b0;
	end
end

endmodule
