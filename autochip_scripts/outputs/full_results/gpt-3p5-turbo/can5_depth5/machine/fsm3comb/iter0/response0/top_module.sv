module top_module (
  input in,
  input [1:0] state,
  output reg [1:0] next_state,
  output reg out
);

  always_comb begin
    case (state)
      2'b00: begin // State A
        if (in)
          next_state = 2'b01; // Transition to B if input is high
        else
          next_state = 2'b00; // Remain in A if input is low
      end
      
      2'b01: begin // State B
        if (in)
          next_state = 2'b01; // Remain in B if input is high
        else
          next_state = 2'b10; // Transition to C if input is low
      end
      
      2'b10: begin // State C
        if (in)
          next_state = 2'b11; // Transition to D if input is high
        else
          next_state = 2'b00; // Transition to A if input is low
      end
      
      2'b11: begin // State D
        if (in)
          next_state = 2'b01; // Transition to B if input is high
        else
          next_state = 2'b10; // Transition to C if input is low
      end
    endcase
  end

  always @(posedge clk) begin
    if (next_state == 2'b11) // Check if current state is D
      out = 1'b1; // Set output high when in state D
    else
      out = 1'b0; // Set output low for other states
  end

endmodule
