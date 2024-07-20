module top_module (
    input clk,
    input in,
    output logic out
);

  reg d;
  reg q;
  wire xor_out;

  assign xor_out = in ^ q;
  
  always @(posedge clk) begin 
    d <= xor_out;
  end
  
  always @(posedge clk) begin
    q <= d;
    out <= q;
  end
  
endmodule
