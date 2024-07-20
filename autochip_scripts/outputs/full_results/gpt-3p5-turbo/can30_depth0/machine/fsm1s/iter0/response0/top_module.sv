module top_module (
  input clk,
  input in,
  input reset,
  output reg out
);
	
  // Define states
  parameter A = 0;
  parameter B = 1;

  // Internal state variable
  reg state;

  // Combinational logic to determine next state
  always @(state or in)
  begin
    if (state == A)
    begin
      if (in == 1'b1)
        state <= A;
      else
        state <= B;
    end
    else if (state == B)
    begin
      if (in == 1'b1)
        state <= B;
      else
        state <= A;
    end
  end
  
  // Update state on rising edge of clk
  always @(posedge clk)
  begin
    if (reset)
      state <= B;
    else
      state <= state;
  end
	
  // Assign output based on state
  always @(state)
  begin
    if (state == B)
      out <= 1'b1;
    else
      out <= 1'b0;
  end
endmodule
