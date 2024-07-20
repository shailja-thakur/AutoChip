module top_module (
  input clk,
  input reset,
  input w,
  output z
);
  reg [2:0] state;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 3'b000; // Initial state is A
    else if (w) begin
      case(state)
        3'b000: state <= 3'b001; // Transition from A to B
        3'b001: state <= 3'b010; // Transition from B to C
        3'b010: state <= 3'b100; // Transition from C to E
        3'b011: state <= 3'b111; // Transition from D to F
        3'b100: state <= 3'b100; // Transition from E to E
        3'b101: state <= 3'b010; // Transition from F to C
        default: state <= state; // No state change
      endcase
    end else begin
      case(state)
        3'b000: state <= 3'b000; // Transition from A to A
        3'b001: state <= 3'b011; // Transition from B to D
        3'b010: state <= 3'b011; // Transition from C to D
        3'b011: state <= 3'b000; // Transition from D to A
        3'b100: state <= 3'b011; // Transition from E to D
        3'b101: state <= 3'b011; // Transition from F to D
        default: state <= state; // No state change
      endcase
    end
  end
  
  assign z = (state == 3'b100) | (state == 3'b101); // z = 1 when state is E or F
endmodule
