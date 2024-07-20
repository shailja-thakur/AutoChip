module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// State register
	reg [1:0] state;
	
	// Combinational logic block
	always @ (posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b00; // Reset state to A
		end else begin
			case (state)
				2'b00: state <= (in) ? 2'b01 : 2'b00; // State A
				2'b01: state <= (in) ? 2'b01 : 2'b10; // State B
				2'b10: state <= (in) ? 2'b11 : 2'b00; // State C
				2'b11: state <= (in) ? 2'b01 : 2'b10; // State D
			endcase
		end
	end
	
	// Output logic
	assign out = (state == 2'b11) ? 1'b1 : 1'b0;
	
endmodule
