module top_module (
  input clk,
  input resetn,
  input [3:1] r,
  output [3:1] g
);

  reg [3:1] state_reg, state_next;

  always @(posedge clk or negedge resetn)
    if (~resetn)
      state_reg <= 3'b000;
    else
      state_reg <= state_next;

  always @(state_reg, r)
    case (state_reg)
      3'b000: if (r[1] & ~r[2] & ~r[3]) state_next = 3'b000;
              else if (r[1]) state_next = 3'b001;
              else if (~r[1] & r[2]) state_next = 3'b010;
              else if (~r[1] & ~r[2] & ~r[3]) state_next = 3'b011;
      3'b001: if (r[2]) state_next = 3'b001;
              else if (~r[1]) state_next = 3'b000;
      3'b010: if (r[3] & ~r[1] & ~r[2]) state_next = 3'b010;
              else if (~r[2]) state_next = 3'b000;
      3'b011: if (r[1] | r[2] | r[3]) state_next = 3'b100;
      3'b100: if (~r[1] & r[2]) state_next = 3'b001;
              else if (~r[1] & ~r[2] & ~r[3]) state_next = 3'b000;
    endcase

  always @(state_reg)
    case (state_reg)
      3'b000: g = 3'b000;
      3'b001: g = 3'b100;
      3'b010: g = 3'b010;
      3'b011: g = 3'b010;
      3'b100: g = 3'b001;
    endcase

endmodule
