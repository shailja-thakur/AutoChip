module top_module (
    input [3:0] a,
    input [3:0] b,
    input [3:0] c,
    input [3:0] d,
    input [3:0] e,
    output reg [3:0] q
);

  always @* begin
    case ({a, b, c, d, e})
      5'b____0: q = b;
      5'b____1: q = e;
      5'b____2: q = a;
      5'b____3: q = d;
      default: q = 'b1111; // f
    endcase
  end
endmodule
