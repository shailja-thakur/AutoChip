module top_module (
  input in,
  input [1:0] state,
  output reg [1:0] next_state,
  output reg out
);

  always_comb begin
    case(state)
      2'b00: // State A
        begin
          if(in)
            next_state = 2'b01; // Transition to State B
          else
            next_state = 2'b00; // Stay in State A
        end
      2'b01: // State B
        begin
          if(in)
            next_state = 2'b01; // Stay in State B
          else
            next_state = 2'b10; // Transition to State C
        end
      2'b10: // State C
        begin
          if(in)
            next_state = 2'b11; // Transition to State D
          else
            next_state = 2'b00; // Transition to State A
        end
      2'b11: // State D
        begin
          if(in)
            next_state = 2'b01; // Transition to State B
          else
            next_state = 2'b10; // Transition to State C
        end
    endcase
  end

  always @(posedge clk) begin
    if(state == 2'b11) // State D
      out <= 1'b1;
    else
      out <= 1'b0;
  end

endmodule
