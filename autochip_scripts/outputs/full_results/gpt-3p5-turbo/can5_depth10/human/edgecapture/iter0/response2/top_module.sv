module top_module(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out);
  
  // Internal wire to hold previous value of input
  reg [31:0] prev_in;
  
  // Synchronous reset
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      out <= 0;
      prev_in <= 0;
    end else begin
      prev_in <= in;
      
      // Check for falling edge and update output accordingly
      out <= (prev_in & ~in) | (out & in);
    end
  end
  
endmodule
