module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

  wire [98:0] shifted_in;
  wire [99:1] shifted_in_any;
  wire [99:0] shifted_in_different;
  
  // shift in[99:1] to the right, inserting a 0 at the LSB
  assign shifted_in = {in[98:0], 1'b0};
  
  // shift in[99:0] to the right, inserting a 0 at the LSB
  assign shifted_in_any = {in[99:1], 1'b0};
  
  // shift in[99:0] to the right, inserting in[99] at the MSB
  assign shifted_in_different = {in[0], in[99:1]};
  
  // Calculate out_both
  assign out_both = in[98:0] & shifted_in;
  
  // Calculate out_any
  assign out_any = in | shifted_in_any;
  
  // Calculate out_different
  assign out_different = in ^ shifted_in_different;

endmodule
