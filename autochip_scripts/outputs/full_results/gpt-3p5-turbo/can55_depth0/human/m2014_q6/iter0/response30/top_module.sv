module top_module (
	input clk,
	input reset,
	input w,
	output z
);
	
	// State declaration
	reg [2:0] current_state;
	reg [2:0] next_state;
	
	// State assignment
	always @(posedge clk or posedge reset) begin
		if (reset)
			current_state <= 3'b000;
		else
			current_state <= next_state;
	end
	
	// Next state logic
	always @(current_state or w) begin
		case (current_state)
			3'b000: // A
				if (w)
					next_state <= 3'b001; // B
				else
					next_state <= 3'b000; // A
			3'b001: // B
				if (w)
					next_state <= 3'b011; // D
				else
					next_state <= 3'b010; // C
			3'b010: // C
				if (w)
					next_state <= 3'b011; // D
				else
					next_state <= 3'b100; // E
			3'b011: // D
				if (w)
					next_state <= 3'b000; // A
				else
					next_state <= 3'b101; // F
			3'b100: // E
				if (w)
					next_state <= 3'b011; // D
				else
					next_state <= 3'b100; // E
			3'b101: // F
				if (w)
					next_state <= 3'b010; // C
				else
					next_state <= 3'b011; // D
		endcase
	end
	
	// Output assignment
	always @(current_state) begin
		case (current_state)
			3'b000, 3'b001, 3'b011, 3'b101: // A, B, D, F
				z <= 1'b0;
			3'b010, 3'b100: // C, E
				z <= 1'b1;
		endcase
	end
	
endmodule
