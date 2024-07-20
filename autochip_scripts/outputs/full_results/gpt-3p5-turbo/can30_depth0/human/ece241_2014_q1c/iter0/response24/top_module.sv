module top_module (
  input [7:0] a,
  input [7:0] b,
  output [7:0] s,
  output overflow
);

  reg [8:0] sum;
  wire sign_a;
  wire sign_b;
  wire sign_sum;
  
  assign sign_a = a[7];
  assign sign_b = b[7];
  assign sign_sum = sum[8];
  
  always @*
  begin
    // Calculate the sum of a and b
    sum = a + b;
    
    // Check if overflow has occurred
    if (sign_a == sign_b)
    begin
      if (sign_a != sign_sum)
        overflow = 1;
      else
        overflow = 0;
    end
    else
      overflow = 0;
    
    // Assign the sum to the output s
    s = sum[7:0];
  end

endmodule
