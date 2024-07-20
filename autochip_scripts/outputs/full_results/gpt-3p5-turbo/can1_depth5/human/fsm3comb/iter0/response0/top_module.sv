module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

	// State transition logic
	always @(*) begin
		case(state)
			2'b00: begin
				if(in)
					next_state = 2'b01; // B
				else
					next_state = 2'b00; // A
			end
			
			2'b01: begin
				if(in)
					next_state = 2'b01; // B
				else
					next_state = 2'b10; // C
			end
			
			2'b10: begin
				if(in)
					next_state = 2'b11; // D
				else
					next_state = 2'b00; // A
			end
			
			2'b11: begin
				if(in)
					next_state = 2'b01; // B
				else
					next_state = 2'b10; // C
			end
		endcase
	end

	// Output logic
	always @(state) begin
		case(state)
			2'b00: out = 1'b0; // 0 for state A
			2'b01: out = 1'b0; // 0 for state B
			2'b10: out = 1'b0; // 0 for state C
			2'b11: out = 1'b1; // 1 for state D
		endcase
	end
	
endmodule
