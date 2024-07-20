module top_module (
  input [7:0] a,
  input [7:0] b,
  output [7:0] s,
  output overflow
);
  
  reg [7:0] s;
  reg overflow;
  
  always @(*) begin
    {overflow, s} = a + b;
  end
  
endmodule
