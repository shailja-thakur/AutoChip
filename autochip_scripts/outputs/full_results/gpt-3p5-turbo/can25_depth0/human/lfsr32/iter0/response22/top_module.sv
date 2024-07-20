module top_module(
  input clk,
  input reset,
  output reg [31:0] q);

  // Define internal signals
  reg [31:0] feedback;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      q <= 32'h1; // Synchronous reset
    end else begin
      // Feedback logic
      feedback[31] <= q[31] ^ q[21] ^ q[1] ^ q[0];
      feedback[30:0] <= q[31:1];
      
      // Update the register
      if (clk) begin
        q <= feedback;
      end
    end
  end
endmodule
