module top_module (
  input clk,
  input reset,
  input x,
  output reg z
);

  reg [2:0] state;
  always @(posedge clk or posedge reset)
  begin
    if (reset)
      state <= 3'b0; // Initializing state to A
    else
    begin
      case (state)
        3'b000: // State A
          begin
            if (x)
              state <= 3'b001; // Next state B
            else
              state <= 3'b000; // Next state A
          end
        3'b001: // State B
          begin
            if (x)
              state <= 3'b110; // Next state E
            else
              state <= 3'b001; // Next state B
          end
        3'b010: // State C
          begin
            if (x)
              state <= 3'b001; // Next state B
            else
              state <= 3'b010; // Next state C
          end
        3'b011: // State D
          begin
            if (x)
              state <= 3'b010; // Next state C
            else
              state <= 3'b001; // Next state B
          end
        3'b100: // State E
          begin
            if (x)
              state <= 3'b100; // Next state D
            else
              state <= 3'b011; // Next state E
          end
        default:
          state <= 3'b0; // Default, initialize to A
      endcase
    end
  end

  always @(posedge clk)
  begin
    if (state == 3'b100 || state == 3'b011)
      z <= 1'b1; // Output high when state is D or E
    else
      z <= 1'b0;
  end

endmodule
