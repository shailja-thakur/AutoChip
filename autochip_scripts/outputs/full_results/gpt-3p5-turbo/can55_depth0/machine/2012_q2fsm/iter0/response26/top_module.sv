module top_module (
  input clk,
  input reset,
  input w,
  output reg z
);

  reg [2:0] state;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 3'b000; // Initial state is A
    else begin
      case({state, w})
        // state A
        3'b000_0: state <= 3'b000; // Remain in A
        3'b000_1: state <= 3'b001; // Transition to B
        // state B
        3'b001_0: state <= 3'b010; // Transition to C
        3'b001_1: state <= 3'b010; // Remain in B
        // state C
        3'b010_0: state <= 3'b011; // Transition to E
        3'b010_1: state <= 3'b011; // Remain in C
        // state D
        3'b011_0: state <= 3'b000; // Transition to A
        3'b011_1: state <= 3'b100; // Transition to F
        // state E
        3'b100_0: state <= 3'b100; // Remain in E
        3'b100_1: state <= 3'b100; // Remain in E
        // state F
        3'b101_0: state <= 3'b100; // Transition to E
        3'b101_1: state <= 3'b011; // Transition to C
        default: state <= 3'b000; // Default to A
      endcase
    end
  end
  
  assign z = (state == 3'b100) || (state == 3'b101);
  
endmodule
