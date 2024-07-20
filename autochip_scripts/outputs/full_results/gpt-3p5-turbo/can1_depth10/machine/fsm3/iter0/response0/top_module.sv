module top_module(
  input clk,
  input in,
  input areset,
  output out
);

  reg [1:0] state;
  
  always @(posedge clk or posedge areset)
  begin
    if (areset)
      state <= 2'b00;  // Reset state to A
    else
    begin
      case (state)
        2'b00:  // State A
          if (in)
            state <= 2'b01;  // Transition to state B if input is 1
          else
            state <= 2'b00;  // Stay in state A if input is 0

        2'b01:  // State B
          if (in)
            state <= 2'b01;  // Stay in state B if input is 1
          else
            state <= 2'b10;  // Transition to state C if input is 0

        2'b10:  // State C
          if (in)
            state <= 2'b11;  // Transition to state D if input is 1
          else
            state <= 2'b00;  // Transition to state A if input is 0

        2'b11:  // State D
          if (in)
            state <= 2'b01;  // Transition to state B if input is 1
          else
            state <= 2'b10;  // Transition to state C if input is 0
      endcase
    end
  end

  assign out = (state == 2'b11) ? 1'b1 : 1'b0;  // Set output to 1 when state is D

endmodule
