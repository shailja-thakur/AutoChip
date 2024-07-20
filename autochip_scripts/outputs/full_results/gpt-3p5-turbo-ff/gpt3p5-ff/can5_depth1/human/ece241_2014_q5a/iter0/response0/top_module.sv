module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	
	// State declaration
	reg [1:0] state;
	
	// Output declaration
	wire z;
	
	// Internal signals
	wire xbar;
	reg [1:0] next_state;
	reg zbar;
	
	// Assign internal signals
	assign xbar = ~x;
	assign z = zbar;
	
	// State transition and output logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b00;  // Initial state
		end else begin
			state <= next_state;  // Next state logic
			zbar <= (state == 2'b10);  // Output logic
		end
	end
	
	// Next state logic
	always @(state or x) begin
		case (state)
			2'b00: if (x == 1'b0) next_state <= 2'b00; else next_state <= 2'b01;  // State 0
			2'b01: if (x == 1'b0) next_state <= 2'b10; else next_state <= 2'b11;  // State 1
			2'b10: if (x == 1'b0) next_state <= 2'b00; else next_state <= 2'b11;  // State 2
			2'b11: if (x == 1'b0) next_state <= 2'b00; else next_state <= 2'b10;  // State 3
			default: next_state <= 2'b00;
		endcase
	end
	
endmodule
