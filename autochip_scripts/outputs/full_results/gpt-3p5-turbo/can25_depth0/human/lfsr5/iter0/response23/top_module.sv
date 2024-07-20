module top_module(
    input clk,
    input reset,
    output reg [4:0] q);
  
  reg [4:0] state;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 1;
    else begin
      state[4] <= state[3];
      state[3] <= state[2];
      state[2] <= state[1]^state[4];
      state[1] <= state[0];
      state[0] <= state[4]^state[2];
    end
  end
  
  assign q = state;
  
endmodule
