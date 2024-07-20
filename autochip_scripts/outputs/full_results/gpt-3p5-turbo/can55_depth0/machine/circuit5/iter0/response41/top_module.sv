module top_module (
  input [3:0] a,
  input [3:0] b,
  input [3:0] c,
  input [3:0] d,
  input [3:0] e,
  output reg [3:0] q
);

  // always block to continuously evaluate the value of c
  always @(*) begin
    case (c)
      0: q = b;  // if c is 0, assign q the value of b
      1: q = e;  // if c is 1, assign q the value of e
      2: q = a;  // if c is 2, assign q the value of a
      3: q = d;  // if c is 3, assign q the value of d
      default: q = 4'hf;  // if c is any other value, assign q the value of 4'hf
    endcase
  end

endmodule
