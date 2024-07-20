module top_module (
  input clk,
  input in,
  input reset,
  output out
);

  reg [1:0] state;
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 2'b00; // Reset to state A
    else begin
      case (state)
        2'b00: begin // State A
          if (in)
            state <= 2'b01; // Change to state B
          else
            state <= 2'b00; // Remain in state B
        end

        2'b01: begin // State B
          if (in)
            state <= 2'b01; // Remain in state B
          else
            state <= 2'b10; // Change to state C
        end

        2'b10: begin // State C
          if (in)
            state <= 2'b11; // Change to state D
          else
            state <= 2'b00; // Change to state A
        end

        2'b11: begin // State D
          if (in)
            state <= 2'b01; // Change to state B
          else
            state <= 2'b10; // Change to state C
        end
      endcase
    end
  end

  assign out = (state == 2'b11); // Output is 1 when in state D

endmodule
