module top_module (
  input [3:0] a, 
  input [3:0] b, 
  input [3:0] c, 
  input [3:0] d,
  input [3:0] e,
  output reg [3:0] q
);

  always @* begin
    case({a, b, c, d, e})
      {4'b0000, 4'bxxxx} : q = b;
      {4'b0001, 4'bxxxx} : q = e;
      {4'b0010, 4'bxxxx} : q = a;
      {4'b0011, 4'bxxxx} : q = d;
      {4'bxxxx, 4'b0000} : q = f;
      default : q = f;
    endcase
  end
endmodule
