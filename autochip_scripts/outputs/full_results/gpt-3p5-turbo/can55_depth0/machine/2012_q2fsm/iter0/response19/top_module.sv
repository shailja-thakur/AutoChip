module top_module (
  input clk,
  input reset,
  input w,
  output reg z
);
  
  reg [2:0] state;

  always @ (posedge clk or posedge reset) begin
    if (reset)
      state <= 3'b000; // Initial state is A
    else begin
      case(state)
        3'b000: // State A
          if (w)
            state <= 3'b001; // Transition to B
        3'b001: // State B
          if (w)
            state <= 3'b010; // Transition to C
          else
            state <= 3'b011; // Transition to D
        3'b010: // State C
          if (w)
            state <= 3'b110; // Transition to E
          else
            state <= 3'b011; // Transition to D
        3'b011: // State D
          if (w)
            state <= 3'b111; // Transition to F
          else
            state <= 3'b000; // Transition to A
        3'b100: // State E
          if (w)
            state <= 3'b100; // Transition to E
          else
            state <= 3'b011; // Transition to D
        3'b111: // State F
          if (w)
            state <= 3'b011; // Transition to D
      endcase
    end
  end

  assign z = (state == 3'b100 || state == 3'b111);

endmodule
