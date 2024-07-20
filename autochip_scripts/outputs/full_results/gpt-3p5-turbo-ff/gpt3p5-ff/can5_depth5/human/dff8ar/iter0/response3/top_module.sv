module top_module(
  input clk,
  input [7:0] d,
  input areset,
  output reg [7:0] q);
  
  reg [7:0] q_temp; // Temporary variable for storing intermediate values
  
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      q_temp <= 8'b0; // Reset the temporary variable to 0
    end else begin
      q_temp <= d; // Assign the input 'd' to the temporary variable
    end
  end
  
  always @(posedge clk) begin
    if (areset) begin
      q <= 8'b0; // Reset the output 'q' to 0
    end else begin
      q <= q_temp; // Assign the value in the temporary variable to the output 'q'
    end
  end
  
endmodule
