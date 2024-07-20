module top_module (
  input clk,
  input in,
  input areset,
  output out
);

  reg [1:0] state;
  wire next_state;

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= 2'b1;
    end else begin
      state <= next_state;
    end
  end

  assign out = (state == 2'b1) ? 1'b1 : 1'b0;

  always @(*) begin
    case (state)
      2'b00: next_state = (in) ? 2'b00 : 2'b01;
      2'b01: next_state = (in) ? 2'b01 : 2'b00;
      default: next_state = 2'b00;
    endcase
  end

endmodule
