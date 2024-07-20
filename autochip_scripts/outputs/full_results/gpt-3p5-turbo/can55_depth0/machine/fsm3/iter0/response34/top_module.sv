module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// State register
	reg [1:0] state;
	
	// Next state logic
	always @(posedge clk, posedge areset) begin
		if (areset)
			state <= 2'b00; // Reset state to A
		else begin
			case (state)
				2'b00: state <= (in) ? 2'b01 : 2'b00; // A -> B or A -> A
				2'b01: state <= (in) ? 2'b01 : 2'b10; // B -> B or B -> C
				2'b10: state <= (in) ? 2'b11 : 2'b00; // C -> D or C -> A
				2'b11: state <= (in) ? 2'b01 : 2'b10; // D -> B or D -> C
				default: state <= 2'b00;
			endcase
		end
	end
	
	// Output assignment
	assign out = (state == 2'b11) ? 1'b1 : 1'b0;
	
endmodule
