module top_module (
  input clk,
  input shift_ena,
  input count_ena,
  input data,
  output reg [3:0] q);
  
  // Internal wire declaration
  wire shift_data;
  
  // Shift register
  always @(posedge clk) begin
    if (shift_ena)
      q <= {data, q[3:1]};
  end
  
  // Counter
  always @(posedge clk) begin
    if (count_ena)
      q <= q - 1;
  end
endmodule
