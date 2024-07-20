module top_module (
  input [3:0] a, 
  input [3:0] b, 
  input [3:0] c, 
  input [3:0] d,
  input [3:0] e,
  output reg [3:0] q
);

  always @(a or b or c or d or e) begin
    case ({a, b, c, d, e})
      5'b01010: q = e;
      5'b01011: q = b;
      5'b01111: q = f;
      default: q = q;
    endcase
  end

endmodule
