module top_module (
  input clk,
  input [7:0] d,
  output reg [7:0] q
);

  reg [7:0] q_temp; // Temporary variable for storing intermediate values of q
  
  always @(posedge clk) begin
    q_temp <= d; // Assign input d to temporary variable q_temp when there is a positive edge of clk
  end
  
  always @(posedge clk) begin
    q <= q_temp; // Assign value of q_temp to output q
  end
  
endmodule
