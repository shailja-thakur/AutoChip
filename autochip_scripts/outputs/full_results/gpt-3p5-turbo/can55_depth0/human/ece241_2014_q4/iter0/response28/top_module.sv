module top_module (
  input clk,
  input x,
  output reg z
);

  reg [2:0] dff_out;
  reg [2:0] dff_in;
  
  dff dff1 (
    .clk(clk),
    .d(x),
    .q(dff_out[0])
  );
  
  dff dff2 (
    .clk(clk),
    .d(x & ~dff_out[0]),
    .q(dff_out[1])
  );
  
  dff dff3 (
    .clk(clk),
    .d(x | ~dff_out[1]),
    .q(dff_out[2])
  );
  
  assign z = ~(dff_out[0] ^ dff_out[1] ^ dff_out[2]);
  
endmodule
module dff (
  input clk,
  input d,
  output reg q
);
  
  always @(posedge clk) begin
    q <= d;
  end
  
endmodule
