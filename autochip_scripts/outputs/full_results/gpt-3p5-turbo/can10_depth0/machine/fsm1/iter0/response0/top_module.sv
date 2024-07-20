module top_module (
  input clk,
  input in,
  input areset,
  output reg out
);

  reg [1:0] state, next_state;

  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= 2'b01;
    else
      state <= next_state;
  end

  always @(state, in) begin
    case (state)
      2'b00: begin
        if (in)
          next_state <= 2'b00;
        else
          next_state <= 2'b01;
      end
      2'b01: begin
        if (in)
          next_state <= 2'b01;
        else
          next_state <= 2'b00;
      end
    endcase
  end

  always @(state) begin
    if (state == 2'b01)
      out <= 1'b1;
    else
      out <= 1'b0;
  end

endmodule
