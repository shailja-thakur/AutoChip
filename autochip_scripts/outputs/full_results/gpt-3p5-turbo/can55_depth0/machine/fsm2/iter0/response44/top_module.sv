module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);
	
	reg [1:0] state;
	wire next_state;

	// Combinational logic for determining next_state
	always @(*) begin
		case(state)
			2'b00: next_state = (j) ? 2'b01 : 2'b00;
			2'b01: next_state = (k) ? 2'b00 : 2'b01;
		endcase
	end

	// Clock-driven logic for updating state
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b00; // Reset to state A
		end else begin
			state <= next_state;
		end
	end
	
	// Output logic
	assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
