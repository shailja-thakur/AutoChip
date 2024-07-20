module top_module (
  input clk,
  input areset,
  input x,
  output z
);
  
  reg [1:0] state;
  reg [1:0] next_state;

  // States enumeration
  parameter A = 2'b00;
  parameter B = 2'b01;
  
  always @(posedge clk or areset)
    if (areset) 
      state <= A;
    else
      state <= next_state;
  
  always @*
    begin
      case(state)
        A: begin
             if (x)
               next_state = B;
             else
               next_state = A;
           end
        B: next_state = B;
      endcase
    end
  
  assign z = (state == A && x) || (state == B && ~x);
  
endmodule
