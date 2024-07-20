module top_module (
  input clk,
  input j,
  input k,
  input areset,
  output out
);

  reg [1:0] state, next_state;

  always_comb begin
    if (state == 2'b00 && j) begin
      next_state = 2'b01;
    end else if (state == 2'b01 && k) begin
      next_state = 2'b00;
    end else begin
      next_state = state;
    end
  end

  always_ff @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= 2'b00;
    end else begin
      state <= next_state;
    end
  end
  
  assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
