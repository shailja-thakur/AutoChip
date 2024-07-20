module top_module (
  input [7:0] a,
  input [7:0] b,
  output [7:0] s,
  output overflow
);
  reg [8:0] sum;
  reg add_overflow;
  
  always @(*) begin
    if (a[7] && b[7] && ~sum[7]) begin
      add_overflow = 1;
    end else if (~a[7] && ~b[7] && sum[7]) begin
      add_overflow = 1;
    end else begin
      add_overflow = 0;
    end
  end
  
  always @(a, b) begin
    sum = a + b;
    s = sum[7:0];
  end
  
  assign overflow = add_overflow;
  
endmodule
