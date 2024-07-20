module top_module (
  input clk,
  input reset,
  input x,
  output reg z
);

  reg [2:0] state;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 3'b000; // Initialize state to A
    else begin
      case (state)
        3'b000: // State A
          if (x)
            state <= 3'b001; // Next state is B if x is high
          else
            state <= 3'b000; // Next state is A if x is low
          
        3'b001: // State B
          if (x)
            state <= 3'b100; // Next state is E if x is high
          else
            state <= 3'b001; // Next state is B if x is low
          
        3'b010: // State C
          if (x)
            state <= 3'b001; // Next state is B if x is high
          else
            state <= 3'b010; // Next state is C if x is low
          
        3'b011: // State D
          if (x)
            state <= 3'b010; // Next state is C if x is high
          else
            state <= 3'b001; // Next state is B if x is low
          
        3'b100: // State E
          if (x)
            state <= 3'b100; // Next state is E if x is high
          else
            state <= 3'b011; // Next state is D if x is low
          
        default:
          state <= 3'b000; // Default state is A
      endcase
    end
  end
  
  always @(state) begin
    if (state == 3'b100 || state == 3'b101)
      z <= 1'b1; // Output is high when state is D or E
    else
      z <= 1'b0;
  end
  
endmodule
