module top_module (
  input clk,
  input areset,
  input x,
  output z
);
  reg [1:0] state;
  
  always @(posedge clk or posedge areset) begin
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
  end
  
  assign z = (state == A && x) || (state == B && !x);
  
  parameter A = 2'b00;
  parameter B = 2'b01;
endmodule
