module top_module (
  input clk,
  input resetn,
  input in,
  output out
);
  
  reg [3:0] d;
  reg [3:0] q;
  
  always @(posedge clk or negedge resetn) begin
    if (~resetn)
      d <= 0;
    else
      d <= {d[2:0], in};
  end
  
  assign out = q[0];
  
  always @(posedge clk) begin
    q <= d;
  end
  
endmodule
