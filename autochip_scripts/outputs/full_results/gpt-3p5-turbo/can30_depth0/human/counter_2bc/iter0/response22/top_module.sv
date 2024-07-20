module top_module (
  input clk,
  input areset,
  input train_valid,
  input train_taken,
  output reg [1:0] state
);

  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= 2'b01;
    else if (train_valid) begin
      if (train_taken) begin
        if (state < 2)
          state <= state + 1;
      end else begin
        if (state > 0)
          state <= state - 1;
      end
    end
  end

endmodule
