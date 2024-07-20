module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
wire [1:0] next_state;

// Combinational logic block for determining the next state
always @ (state, in) begin
  case (state)
    2'b00: // State A
      if (in)
        next_state = 2'b01; // Next state B
      else
        next_state = 2'b00; // Next state A
    2'b01: // State B
      if (in)
        next_state = 2'b01; // Next state B
      else
        next_state = 2'b10; // Next state C
    2'b10: // State C
      if (in)
        next_state = 2'b11; // Next state D
      else
        next_state = 2'b00; // Next state A
    2'b11: // State D
      if (in)
        next_state = 2'b01; // Next state B
      else
        next_state = 2'b10; // Next state C
    default:
      next_state = 2'b00; // Default next state A
  endcase
end

// Sequential logic block for updating the state register
always @(posedge clk) begin
  if (areset)
    state <= 2'b00; // Reset state A
  else
    state <= next_state; // Update state
end

// Output logic
assign out = (state == 2'b11) ? 1'b1 : 1'b0; // Set out to 1 when state is D

endmodule
