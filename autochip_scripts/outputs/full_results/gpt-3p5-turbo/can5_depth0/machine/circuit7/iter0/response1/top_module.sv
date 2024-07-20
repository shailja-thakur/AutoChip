module top_module (
  input clk,
  input a,
  output reg q
);
  
  // Positive edge-triggered always block
  always @(posedge clk) begin
    q <= ~a; // Set output q to inverse of input a
  end
  
endmodule
