module top_module (
  input clk,
  input j,
  input k,
  input areset,
  output reg out
);

reg [1:0] state;
reg [1:0] next_state;

always @*
begin
  next_state = state;
  case (state)
    2'b00: // State A
      begin
        if (j)
          next_state = 2'b01; // Transition to State B
        else
          next_state = 2'b00; // Stay in State A
      end
      
    2'b01: // State B
      begin
        if (k)
          next_state = 2'b00; // Transition to State A
        else
          next_state = 2'b01; // Stay in State B
      end
  endcase
end

always @(posedge clk or posedge areset)
begin
  if (areset)
    state <= 2'b00; // Reset to State A
  else
    state <= next_state;
end

assign out = (state == 2'b01) ? 1'b1 : 1'b0; // Set out to 1 if State B, otherwise 0

endmodule
