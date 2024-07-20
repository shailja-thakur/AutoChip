module top_module (
  input [3:0] in,
  output reg [2:0] out_both,
  output reg [3:1] out_any,
  output reg [3:0] out_different
);

  always @(*) begin
    out_both = in[2:0] & in[3:1];
    out_any = in[2:0] | in[3:1];
    out_different = {in[3:1], in[0]} ^ {4{in[3:1]}};
  end

endmodule
