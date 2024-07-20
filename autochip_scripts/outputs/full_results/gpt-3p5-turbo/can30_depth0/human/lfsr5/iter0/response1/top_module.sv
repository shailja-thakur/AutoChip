module top_module(
	input clk,
	input reset,
	output reg [4:0] q);
	
  reg [4:0] feedback;
	
  always @(posedge clk or posedge reset) begin
    if (reset)
      q <= 1;
    else begin
      feedback <= q[4] ^ q[2] ^ q[0];
      q <= {q[3:0], feedback};
    end
  end
  
endmodule
