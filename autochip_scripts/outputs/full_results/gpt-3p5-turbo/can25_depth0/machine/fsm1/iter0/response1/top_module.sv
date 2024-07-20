module top_module (
  input wire clk,
  input wire in,
  input wire areset,
  output wire out
);

  reg state; // state register

  always @(posedge clk) begin
    if (areset)
      state <= 1'b0; // reset to state B
    else if (state == 1'b0) begin // current state is B
      if (in)
        state <= 1'b0; // next state is B
      else
        state <= 1'b1; // next state is A
    end else begin // current state is A
      if (in)
        state <= 1'b1; // next state is A
      else
        state <= 1'b0; // next state is B
    end
  end

  assign out = ~state; // output is high when state is B, low otherwise

 endmodule
