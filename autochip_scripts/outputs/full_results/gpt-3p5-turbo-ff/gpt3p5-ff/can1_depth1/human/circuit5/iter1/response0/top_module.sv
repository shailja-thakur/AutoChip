module top_module (
  input [3:0] a, 
  input [3:0] b, 
  input [3:0] c, 
  input [3:0] d,
  input [3:0] e,
  output reg [3:0] q
);

always @* begin
  case ({a,b,c,d,e})
    // 15ns
    4'b0000_0101: q = b;
    // 20ns
    4'b0001_0011: q = e;
    // 25ns
    4'b0010_0100: q = a;
    // 30ns
    4'b0011_1101: q = d;
    // 35ns
    4'b0100_0111: q = 4'b1111;
    // 40ns, 45ns, 50ns, 55ns, 60ns, 65ns, 70ns, 75ns, 80ns, 85ns, 90ns
    default: q = 4'b1111;
  endcase
end

endmodule
