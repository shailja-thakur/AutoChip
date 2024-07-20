module top_module(
  input clk,
  input reset,
  output reg [31:0] q);
  
  reg [31:0] state;

  always @(posedge clk) begin
    if (reset) begin
      state <= 32'h1;
      q <= 32'h1;
    end
    else begin
      state <= {state[0] ^ state[31], state[31:1]};
      q <= state;
    end
  end
  
endmodule
