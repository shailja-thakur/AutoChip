module top_module (
	input clk,
	input in,
	input reset,
	output out
);

  reg [1:0] state;
  
  always @(posedge clk) begin
    if (reset)
      state <= 2'b1;
    else if (state == 2'b1 && in)
      state <= 2'b1;
    else if (state == 2'b1 && !in)
      state <= 2'b0;
    else if (state == 2'b0 && in)
      state <= 2'b0;
    else if (state == 2'b0 && !in)
      state <= 2'b1;
  end
  
  assign out = (state == 2'b0) ? 1'b1 : 1'b0;
  
endmodule
