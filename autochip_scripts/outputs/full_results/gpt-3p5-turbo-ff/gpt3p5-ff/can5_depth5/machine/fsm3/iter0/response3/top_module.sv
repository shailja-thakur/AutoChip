module top_module (
	input wire clk,
	input wire in,
	input wire areset,
	output wire out
);

reg [1:0] state;
wire [1:0] next_state;

// Combinational logic block to determine the next state
assign next_state[0] = (state[0] == 0) ? 
						(in ? 1 : 0) : // State A transitions
						(in ? 0 : 1); // State B, C, D transitions

assign next_state[1] = (state[1] == 0) ?
						(in ? 0 : 1) : // State A, C transitions
						(in ? 1 : 0); // State B, D transitions

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= 2'b00; // Reset to state A
		out <= 0; // Reset output to 0
	end
	else begin
		state <= next_state;
		out <= (state == 2'b11) ? 1 : 0; // Set output to 1 when in state D
	end
end

endmodule
