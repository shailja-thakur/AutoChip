module top_module (
    input [99:0] a,
    input [99:0] b,
    input sel,
    output [99:0] out
);
  wire [99:0] out_temp;
  
  assign out = sel ? b : a;
endmodule
