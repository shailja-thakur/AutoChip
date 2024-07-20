module top_module (
  input clk,
  input areset,
  input x,
  output z
);
  
  reg [1:0] state;
  
  always @(posedge clk or areset)
    if (areset) 
      state <= A;
    else begin
      case(state)
        A: if (x)
             state <= B;
           else
             state <= A;
        B: state <= B;
      endcase
    end
   
  assign z = (state == A && x) || (state == B && !x);
  
endmodule
