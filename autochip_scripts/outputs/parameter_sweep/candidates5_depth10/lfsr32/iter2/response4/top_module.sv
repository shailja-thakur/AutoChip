module top_module(
  input clk,
  input reset,
  output reg [31:0] q
);

  always @(posedge clk or posedge reset) begin
    // Synchronous reset
    if (reset) begin
      q <= 32'h1;
    end 
    else begin
      // Feedback function
      q[31] <= q[22] ^ q[10] ^ q[1] ^ q[0];
      q[30:0] <= {q[31:1]};
    end
  end
  
endmodule
