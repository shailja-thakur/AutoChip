module top_module (
  input clk,
  input j,
  input k,
  input areset,
  output reg out
);

reg [1:0] state, next_state;

// Combinational always block to determine next state
always @*
begin
  case (state)
    A: next_state = (j == 1'b1) ? B : A;
    B: next_state = (k == 1'b1) ? A : B;
  endcase
end

// Clocked always block to update state based on areset and next_state
always @(posedge clk)
begin
  if (areset == 1'b1)
    state <= A;
  else
    state <= next_state;
end

// Assign out port based on the current state
assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
