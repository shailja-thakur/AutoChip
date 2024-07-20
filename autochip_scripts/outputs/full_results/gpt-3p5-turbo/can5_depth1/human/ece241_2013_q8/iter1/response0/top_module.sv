module top_module (
  input clk,
  input aresetn,
  input x,
  output reg z
);
  reg [2:0] state, next_state;

  always @(posedge clk, negedge aresetn)
  begin
    if (~aresetn)
      state <= 3'b000;
    else
      state <= next_state;
  end

  always @(state, x)
  begin
    case(state)
      3'b000:
        if (x == 1'b1)
          next_state <= 3'b001;
        else
          next_state <= 3'b000;
      3'b001:
        if (x == 1'b0)
          next_state <= 3'b010;
        else
          next_state <= 3'b000;
      3'b010:
        if (x == 1'b1)
          next_state <= 3'b011;
        else
          next_state <= 3'b000;
      3'b011:
        if (x == 1'b0)
          next_state <= 3'b010;
        else
          next_state <= 3'b000;
      default: next_state <= 3'b000;
    endcase
  end

  always @(state)
  begin
    case(state)
      3'b011:
        z <= 1'b1;
      default: z <= 1'b0;
    endcase
  end
endmodule
