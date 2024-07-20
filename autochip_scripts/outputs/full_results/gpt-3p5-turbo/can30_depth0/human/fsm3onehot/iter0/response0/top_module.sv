module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output out
);

always @(*)
begin
	case(state)
		4'b0001: // State A
		begin
			if(in)
			begin
				next_state = 4'b0010; // Transition to State B
				out = 1'b0; // Output = 0
			end
			else
			begin
				next_state = 4'b0001; // Stay in State A
				out = 1'b0; // Output = 0
			end
		end

		4'b0010: // State B
		begin
			if(in)
			begin
				next_state = 4'b0010; // Stay in State B
				out = 1'b0; // Output = 0
			end
			else
			begin
				next_state = 4'b0100; // Transition to State C
				out = 1'b0; // Output = 0
			end
		end

		4'b0100: // State C
		begin
			if(in)
			begin
				next_state = 4'b0001; // Transition to State A
				out = 1'b0; // Output = 0
			end
			else
			begin
				next_state = 4'b1000; // Transition to State D
				out = 1'b0; // Output = 0
			end
		end

		4'b1000: // State D
		begin
			if(in)
			begin
				next_state = 4'b0100; // Transition to State C
				out = 1'b1; // Output = 1
			end
			else
			begin
				next_state = 4'b0010; // Transition to State B
				out = 1'b0; // Output = 0
			end
		end
	endcase
end

endmodule
