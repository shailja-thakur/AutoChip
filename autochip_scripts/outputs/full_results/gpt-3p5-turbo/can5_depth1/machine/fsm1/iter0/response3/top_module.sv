module top_module (
  input clk,
  input in,
  input areset,
  output out
);

  reg currentState, nextState;

  always @(posedge clk, posedge areset)
  begin
    if (areset)
      currentState <= 0;
    else
      currentState <= nextState;
  end

  always @(currentState, in)
  begin
    case (currentState)
      0: if (in)
           nextState = 0;
         else
           nextState = 1;
      1: if (in)
           nextState = 1;
         else
           nextState = 0;
    endcase
  end

  assign out = (currentState == 1) ? 1'b1 : 1'b0;

endmodule
