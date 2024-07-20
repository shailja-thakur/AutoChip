module top_module (
  input clk,
  input j,
  input k,
  input reset,
  output reg out
);
  
  reg [1:0] state;
  reg [1:0] next_state;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 2'b00; // Initializing state A
    else
      state <= next_state;
  end
  
  always @(state, j, k) begin
    case (state)
      2'b00: begin // State A
        if (j)
          next_state = 2'b01; // Transition to state B
        else
          next_state = 2'b00; // Remain in state A
      end
      2'b01: begin // State B
        if (k)
          next_state = 2'b00; // Transition to state A
        else
          next_state = 2'b01; // Remain in state B
      end
      default: begin
        next_state = 2'b00; // Default case for any undefined state
      end
    endcase
  end
  
  assign out = (state == 2'b01); // Output is high when in state B, low otherwise
  
endmodule
