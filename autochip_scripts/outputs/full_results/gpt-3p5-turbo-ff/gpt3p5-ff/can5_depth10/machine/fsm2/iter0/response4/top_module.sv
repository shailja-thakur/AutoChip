module top_module (
  input clk,
  input j,
  input k,
  input areset,
  output reg out
);

  reg [1:0] state, next_state;

  always @(*) begin
    case(state)
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
    endcase
  end

  always @(posedge clk) begin
    if (areset)
      state <= 2'b00;
    else
      state <= next_state;
  end

  always @(state) begin
    if (state == 2'b01)
      out <= 1'b1;
    else
      out <= 1'b0;
  end

endmodule
