module top_module (
	input clk,
	input reset,
	input w,
	output z
);
	// State register
	reg [2:0] state;

	// Next state logic
	always @(posedge clk, posedge reset) begin
		if (reset == 1'b1) begin
			state <= 3'b000; // Initial state is A
		end else begin
			case ({state, w})
				3'b0000 : state <= 3'b000; // A to A
				3'b0001 : state <= 3'b001; // A to B
				3'b0010 : state <= 3'b010; // B to C
				3'b0011 : state <= 3'b011; // B to D
				3'b0100 : state <= 3'b010; // C to E
				3'b0101 : state <= 3'b011; // C to D
				3'b0110 : state <= 3'b101; // D to F
				3'b0111 : state <= 3'b000; // D to A
				3'b1000 : state <= 3'b101; // E to E
				3'b1001 : state <= 3'b010; // E to C
				3'b1010 : state <= 3'b011; // F to D
				default : state <= 3'b000; // Default case
			endcase
		end
	end
	
	// Output logic
	assign z = (state == 3'b100) || (state == 3'b101);
	
endmodule
