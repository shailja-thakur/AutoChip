module top_module (
  input clk,
  input reset,
  input w,
  output z
);
  
  reg [2:0] state;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 3'b000;    // Reset to initial state A
    else
      case (state)
        3'b000: state <= w ? 3'b001 : 3'b000;    // Transition from A to B if w = 1, otherwise stay in A
        3'b001: state <= w ? 3'b010 : 3'b010;    // Transition from B to C if w = 1, otherwise stay in B
        3'b010: state <= w ? 3'b100 : 3'b011;    // Transition from C to E if w = 1, otherwise transition to D
        3'b011: state <= w ? 3'b000 : 3'b000;    // Transition from D to A if w = 1, otherwise stay in D
        3'b100: state <= w ? 3'b100 : 3'b010;    // Transition from E to E if w = 1, otherwise transition to D
        3'b101: state <= w ? 3'b010 : 3'b010;    // Transition from F to C if w = 1, otherwise stay in F
      endcase
  end
  
  assign z = (state == 3'b100) || (state == 3'b101);    // Set z to 1 when state is E or F
endmodule
