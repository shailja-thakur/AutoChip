module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output out
);

	// State transition logic
	always @(*) begin
		case (state)
			4'b0001: begin // State A
				if (in)
					next_state = 4'b0010; // A -> B
				else
					next_state = 4'b0001; // A -> A
			end
			4'b0010: begin // State B
				if (in)
					next_state = 4'b0010; // B -> B
				else
					next_state = 4'b0100; // B -> C
			end
			4'b0100: begin // State C
				if (in)
					next_state = 4'b1000; // C -> D
				else
					next_state = 4'b0001; // C -> A
			end
			4'b1000: begin // State D
				if (in)
					next_state = 4'b0010; // D -> B
				else
					next_state = 4'b0100; // D -> C
			end
			default: next_state = 4'b0001; // Default to state A
		endcase
	end

	// Output logic
	assign out = (state == 4'b1000);

endmodule
