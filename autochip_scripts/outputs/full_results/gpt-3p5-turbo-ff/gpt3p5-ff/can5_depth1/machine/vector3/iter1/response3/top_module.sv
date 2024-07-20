module top_module (
  input [4:0] a,
  input [4:0] b,
  input [4:0] c,
  input [4:0] d,
  input [4:0] e,
  input [4:0] f,
  output reg [7:0] w,
  output reg [7:0] x,
  output reg [7:0] y,
  output reg [7:0] z
);

  // Concatenating inputs a, b, c, d, e, f and 2'b11
  always @* begin
    {w, x, y, z} = {a, b, c, d, e, f, 2'b11};
  end
  
endmodule
