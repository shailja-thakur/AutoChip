module top_module (
  input clk,
  input j,
  input k,
  input reset,
  output out
);

  reg [1:0] state;
  wire next_state_A;
  wire next_state_B;

  assign out = (state == 2'b10);

  DFF dff_A (clk, reset, state[0], next_state_A);
  DFF dff_B (clk, reset, state[1], next_state_B);

  always @(posedge clk) begin
    if (reset) begin
      state <= 2'b00;
    end else begin
      if (state == 2'b00) begin
        state <= j ? 2'b10 : 2'b00;
      end else begin
        state <= k ? 2'b00 : 2'b10;
      end
    end
  end

endmodule
module DFF (
  input clk,
  input reset,
  input D,
  output reg Q
);

  always @(posedge clk, posedge reset) begin
    if (reset) begin
      Q <= 1'b0;
    end else begin
      Q <= D;
    end
  end

endmodule
