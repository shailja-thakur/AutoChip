module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
  
  reg [1:0] state;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 2'b00; // Initialize to state A
    else if (state == 2'b00)
      state <= j ? 2'b01 : 2'b00; // Transition from A to B if j is high
    else if (state == 2'b01)
      state <= k ? 2'b00 : 2'b01; // Transition from B to A if k is high
  end
  
  assign out = (state == 2'b01) ? 1'b1 : 1'b0; // Output is high when state is B
  
endmodule
