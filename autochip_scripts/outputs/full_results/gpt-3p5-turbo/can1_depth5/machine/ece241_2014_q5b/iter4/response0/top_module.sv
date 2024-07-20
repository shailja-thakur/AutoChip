module top_module (
  input clk,
  input areset,
  input x,
  output z
);
  
  reg state;
  reg next_state;

  // States enumeration
  parameter A = 1'b0;
  parameter B = 1'b1;
  
  always @(posedge clk or areset)
    if (areset) 
      state <= A;
    else
      state <= next_state;
  
  always @*
    begin
      case(state)
        A: if (x)
             next_state = B;
           else
             next_state = A;
        B: next_state = B;
	  endcase
    end
  
  assign z = (state == A && x) || (state == B && ~x);
  
endmodule
