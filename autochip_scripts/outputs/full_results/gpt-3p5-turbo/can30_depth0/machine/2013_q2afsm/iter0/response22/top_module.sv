module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);
	// Registers
	reg [3:1] state;
	reg [3:1] next;

	// Assign initial value to state register
	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			state <= 3'b001;		// Set initial state to A
		end else begin
			state <= next;			// Update current state with next state value
		end
	end

	// Determine next state
	always @(*) begin
		case(state)
			3'b001: begin		// Current state is A
				if (r[3]) begin
					next = 3'b100;	// Next state is D if r[3] is high
				end else if (r[2]) begin
					next = 3'b011;	// Next state is C if r[2] is high
				end else if (r[1]) begin
					next = 3'b010;	// Next state is B if r[1] is high
				end else begin
					next = 3'b001;	// Next state is A if none of the bits of r are high
				end
			end
			
			3'b010: begin		// Current state is B
				if (r[1]) begin
					next = 3'b010;	// Next state is B if r[1] is high
				end else begin
					next = 3'b001;	// Next state is A if r[1] is low
				end
			end

			3'b011: begin		// Current state is C
				if (r[2]) begin
					next = 3'b011;	// Next state is C if r[2] is high
				end else begin
					next = 3'b001;	// Next state is A if r[2] is low
				end
			end

			3'b100: begin		// Current state is D
				if (r[3]) begin
					next = 3'b100;	// Next state is D if r[3] is high
				end else begin
					next = 3'b001;	// Next state is A if r[3] is low
				end
			end

			default: next = 3'b001;	// Default next state is A
		endcase
	end

	// Assign output vector g
	always @(state) begin
		case(state)
			3'b001: g = 3'b000;		// Current state is A
			3'b010: g = 3'b001;		// Current state is B
			3'b011: g = 3'b010;		// Current state is C
			3'b100: g = 3'b100;		// Current state is D
			default: g = 3'b000;		// Default output is all zeros
		endcase
	end

endmodule
