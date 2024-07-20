module top_module (
  input clk,
  input in,
  input reset,
  output out
);

  reg [1:0] state;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 2'b1; // Initial state B
    else if (state == 2'b01 && in) 
      state <= 2'b01; // Transition from A to A if in is high
    else if (state == 2'b01 && !in) 
      state <= 2'b10; // Transition from A to B if in is low
    else if (state == 2'b10 && in) 
      state <= 2'b10; // Transition from B to B if in is high
    else if (state == 2'b10 && !in) 
      state <= 2'b01; // Transition from B to A if in is low
  end
  
  assign out = (state == 2'b10) ? 1'b1 : 1'b0;
  
endmodule
