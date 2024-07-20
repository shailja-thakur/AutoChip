module top_module (
  input clk,
  input in,
  input areset,
  output out
);

  reg [1:0] state;
  wire [1:0] next_state;
  reg out_reg;

  always @(posedge clk or posedge areset)
  begin
    if (areset)
      state <= 2'b00;
    else
      state <= next_state;
  end

  always @(*)
  begin
    case (state)
      2'b00: next_state = (in) ? 2'b10 : 2'b01;
      2'b01: next_state = (in) ? 2'b11 : 2'b01;
      2'b10: next_state = (in) ? 2'b10 : 2'b11;
      2'b11: next_state = (in) ? 2'b11 : 2'b01;
    endcase
  end

  always @(state)
  begin
    case (state)
      2'b00: out_reg = 1'b0;
      2'b01: out_reg = 1'b0;
      2'b10: out_reg = 1'b0;
      2'b11: out_reg = 1'b1;
    endcase
  end

  assign out = out_reg;

endmodule
