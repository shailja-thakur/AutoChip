module top_module (
  input clk,
  input in,
  input reset,
  output out
);

  reg [1:0] state;
  reg out_reg;

  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 2'b00; // Reset to state A
    else begin
      case (state)
        2'b00: if (in) state <= 2'b01; else state <= 2'b00;
        2'b01: if (in) state <= 2'b01; else state <= 2'b10;
        2'b10: if (in) state <= 2'b11; else state <= 2'b00;
        2'b11: if (in) state <= 2'b01; else state <= 2'b10;
      endcase
    end
  end

  always @(state)
    case (state)
      2'b00: out_reg <= 1'b0;
      2'b01: out_reg <= 1'b0;
      2'b10: out_reg <= 1'b0;
      2'b11: out_reg <= 1'b1;
    endcase

  assign out = out_reg;

endmodule
