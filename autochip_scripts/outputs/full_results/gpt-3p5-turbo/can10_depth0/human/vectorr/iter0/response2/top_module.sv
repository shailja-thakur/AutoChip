module top_module (
  input [7:0] in,
  output [7:0] out
);
  
  // Wire declaration
  wire [7:0] reversed;

  // Bit Reversal Logic
  assign reversed[0] = in[7];
  assign reversed[1] = in[6];
  assign reversed[2] = in[5];
  assign reversed[3] = in[4];
  assign reversed[4] = in[3];
  assign reversed[5] = in[2];
  assign reversed[6] = in[1];
  assign reversed[7] = in[0];

  // Output assignment
  assign out = reversed;
  
endmodule
