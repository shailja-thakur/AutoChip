module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

	always @(*)
	begin
		case(state)
			2'b00: // State A
				begin
					if (in == 1'b0)
					begin
						next_state = 2'b00; // Next state is A
						out = 1'b0;
					end
					else if (in == 1'b1)
					begin
						next_state = 2'b01; // Next state is B
						out = 1'b0;
					end
				end
			2'b01: // State B
				begin
					if (in == 1'b0)
					begin
						next_state = 2'b10; // Next state is C
						out = 1'b0;
					end
					else if (in == 1'b1)
					begin
						next_state = 2'b01; // Next state is B
						out = 1'b0;
					end
				end
			2'b10: // State C
				begin
					if (in == 1'b0)
					begin
						next_state = 2'b00; // Next state is A
						out = 1'b0;
					end
					else if (in == 1'b1)
					begin
						next_state = 2'b11; // Next state is D
						out = 1'b0;
					end
				end
			2'b11: // State D
				begin
					if (in == 1'b0)
					begin
						next_state = 2'b10; // Next state is C
						out = 1'b1;
					end
					else if (in == 1'b1)
					begin
						next_state = 2'b01; // Next state is B
						out = 1'b1;
					end
				end
		endcase
	end
endmodule
