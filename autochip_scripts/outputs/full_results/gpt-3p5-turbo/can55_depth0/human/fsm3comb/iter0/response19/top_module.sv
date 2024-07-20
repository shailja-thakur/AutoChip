module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

	// State transition logic
	always @(*)
	begin
		case(state)
			2'b00: // A
			begin
				if(in == 0)
				begin
					next_state = 2'b00; // A
				end
				else if(in == 1)
				begin
					next_state = 2'b01; // B
				end
			end
			2'b01: // B
			begin
				if(in == 0)
				begin
					next_state = 2'b10; // C
				end
				else if(in == 1)
				begin
					next_state = 2'b01; // B
				end
			end
			2'b10: // C
			begin
				if(in == 0)
				begin
					next_state = 2'b00; // A
				end
				else if(in == 1)
				begin
					next_state = 2'b11; // D
				end
			end
			2'b11: // D
			begin
				if(in == 0)
				begin
					next_state = 2'b10; // C
				end
				else if(in == 1)
				begin
					next_state = 2'b01; // B
				end
			end
		endcase
	end

	// Output logic
	always @(state)
	begin
		case(state)
			2'b00: // A
				out = 0;
			2'b01: // B
				out = 0;
			2'b10: // C
				out = 0;
			2'b11: // D
				out = 1;
		endcase
	end

endmodule
