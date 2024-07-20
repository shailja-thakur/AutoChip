module top_module (
    input [255:0] in,
    input [7:0] sel,
    output wire out
);
  
  wire [255:0] selected_bit;
  
  assign selected_bit = in[sel];
  assign out = selected_bit[0];
  
endmodule
