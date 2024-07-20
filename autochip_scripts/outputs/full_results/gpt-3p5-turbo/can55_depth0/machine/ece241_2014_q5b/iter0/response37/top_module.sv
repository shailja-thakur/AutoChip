module top_module (
  input clk,
  input areset,
  input x,
  output z
);
 
  // Define states
  parameter A = 0;
  parameter B = 1;
 
  reg state;
  reg z;
 
  always @(posedge clk or posedge areset)
  begin
    if (areset)
      state <= A;
    else
    begin
      case (state)
        A: begin
          if (x)
            state <= B;
        end
        B: begin
          state <= B;
        end
      endcase
    end
  end
 
  always @(*)
  begin
    if (state == A && x)
      z = 1;
    else if (state == B && !x)
      z = 1;
    else
      z = 0;
  end
 
endmodule
