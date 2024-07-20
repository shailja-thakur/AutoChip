module top_module (
  input clk,
  input j,
  input k,
  input areset,
  output out
);

  reg [1:0] state, next_state;

  always_comb begin
    case (state)
      2'b00:
        if (j)
          next_state = 2'b01;
        else
          next_state = 2'b00;
      2'b01:
        if (k)
          next_state = 2'b00;
        else
          next_state = 2'b01;
    endcase
  end

  always_ff @(posedge clk) begin
    if (areset)
      state <= 2'b00;
    else
      state <= next_state;
  end

  assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
