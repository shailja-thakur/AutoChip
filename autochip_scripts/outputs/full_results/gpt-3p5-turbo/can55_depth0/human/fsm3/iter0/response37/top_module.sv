module moore_state_machine (
  input clk,
  input in,
  input areset,
  output out
);

  reg [1:0] state;
  reg next_state;
  reg out_reg;

  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= 2'b00; // Reset to state A
    else
      state <= next_state;
  end

  always @* begin
    case(state)
      2'b00: begin // State A
        next_state = in ? 2'b10 : 2'b01; // Next state based on input
        out_reg = 0; // Output for state A is 0
      end
      2'b01: begin // State B
        next_state = in ? 2'b10 : 2'b01; // Next state based on input
        out_reg = 0; // Output for state B is 0
      end
      2'b10: begin // State C
        next_state = in ? 2'b01 : 2'b11; // Next state based on input
        out_reg = 0; // Output for state C is 0
      end
      2'b11: begin // State D
        next_state = in ? 2'b01 : 2'b10; // Next state based on input
        out_reg = 1; // Output for state D is 1
      end
    endcase
  end

  always @(posedge clk) begin
    out <= out_reg; // Output register
  end

endmodule
module top_module (
  input clk,
  input in,
  input areset,
  output out
);

  moore_state_machine fsm (
    .clk(clk),
    .in(in),
    .areset(areset),
    .out(out)
  );

endmodule
