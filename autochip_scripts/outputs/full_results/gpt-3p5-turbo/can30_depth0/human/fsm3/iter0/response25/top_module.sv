module top_module (
  input clk,
  input in,
  input areset,
  output out
);

  reg [1:0] state;
  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= 2'b00; // Reset to state A
    else begin
      case (state)
        2'b00: begin // State A
          if (in)
            state <= 2'b01; // Next state B if input is 1
          else
            state <= 2'b00; // Next state A if input is 0
        end
        2'b01: begin // State B
          if (in)
            state <= 2'b01; // Next state B if input is 1
          else
            state <= 2'b10; // Next state C if input is 0
        end
        2'b10: begin // State C
          if (in)
            state <= 2'b11; // Next state D if input is 1
          else
            state <= 2'b00; // Next state A if input is 0
        end
        2'b11: begin // State D
          if (in)
            state <= 2'b01; // Next state B if input is 1
          else
            state <= 2'b10; // Next state C if input is 0
        end
      endcase
    end
  end

  always @(state) begin
    case (state)
      2'b00: out = 1'b0; // Output 0 for state A
      2'b01: out = 1'b0; // Output 0 for state B
      2'b10: out = 1'b0; // Output 0 for state C
      2'b11: out = 1'b1; // Output 1 for state D
    endcase
  end

endmodule
