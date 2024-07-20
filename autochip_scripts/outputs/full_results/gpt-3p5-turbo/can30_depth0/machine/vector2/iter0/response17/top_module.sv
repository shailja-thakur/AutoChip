module top_module (
  input [31:0] in,
  output [31:0] out
);
    reg [7:0] out0, out1, out2, out3;
    
    assign {out3, out2, out1, out0} = in;

    assign out = {out3, out2, out1, out0};
endmodule
