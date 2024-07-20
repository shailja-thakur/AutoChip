module top_module (
  input clk,
  input in,
  input reset,
  output out
);

  reg [1:0] state;
  reg out_reg;

  always @(posedge clk) begin
    if (reset)
      state <= 0;
    else
      case (state)
        2'b00: state <= (in) ? 2'b01 : 2'b10;
        2'b01: state <= (in) ? 2'b10 : 2'b01;
        2'b10: state <= (in) ? 2'b00 : 2'b11;
        2'b11: state <= (in) ? 2'b10 : 2'b01;
      endcase
  end

  always @(posedge clk)
    case (state)
      2'b10: out_reg <= 1'b1;
      default: out_reg <= 1'b0;
    endcase

  assign out = out_reg;

endmodule
