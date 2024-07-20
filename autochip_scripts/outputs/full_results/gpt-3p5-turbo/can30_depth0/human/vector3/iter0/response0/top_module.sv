module top_module (
  input [4:0] a,
  input [4:0] b,
  input [4:0] c,
  input [4:0] d,
  input [4:0] e,
  input [4:0] f,
  output [7:0] w,
  output [7:0] x,
  output [7:0] y,
  output [7:0] z
);
  reg [29:0] input_vectors;
  reg [31:0] output_vectors;
  
  always @* begin
    input_vectors = {a, b, c, d, e, f};
    output_vectors = {input_vectors, 2'b11};
  end

  assign {w, x, y, z} = output_vectors;

endmodule
