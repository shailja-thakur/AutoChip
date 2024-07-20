module top_module (
  input clk,
  input j,
  input k,
  input areset,
  output out
);

  reg [1:0] state;
  wire next_state;

  always @(state, j, k) begin
    case (state)
      2'b00: begin
        if (j)
          next_state = 2'b01;
        else
          next_state = 2'b00;
      end
      2'b01: begin
        if (k)
          next_state = 2'b00;
        else
          next_state = 2'b01;
      end
      default: next_state = 2'b00;
    endcase
  end

  always @(posedge clk) begin
    if (areset)
      state <= 2'b00;
    else
      state <= next_state;
  end

  assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
