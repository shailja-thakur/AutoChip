module top_module (
  input clk,
  input reset,
  input w,
  output reg z
);
  
  reg [2:0] state; // state register
  
  // State transition logic
  always @(posedge clk) begin
    if (reset)
      state <= 3'b001; // Reset to state A
    else begin
      case (state)
        3'b000: state <= (w) ? 3'b000 : 3'b001; // A to A or A to B
        3'b001: state <= (w) ? 3'b010 : 3'b011; // B to D or B to C
        3'b010: state <= (w) ? 3'b001 : 3'b100; // C to D or C to E
        3'b011: state <= (w) ? 3'b000 : 3'b101; // D to A or D to F
        3'b100: state <= (w) ? 3'b010 : 3'b100; // E to D or E to E
        3'b101: state <= (w) ? 3'b010 : 3'b011; // F to D or F to C
        default: state <= 3'b001; // Default transition to state A
      endcase
    end
  end
  
  // Output assignment
  always @(state) begin
    case (state)
      3'b100, 3'b101: z <= 1; // State E or F => z = 1
      default: z <= 0; // Other states => z = 0
    endcase
  end
endmodule
