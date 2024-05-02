module top_module (
  input clk,
  input load,
  input [511:0] data,
  output [511:0] q
);

  reg [511:0] state;
  reg [511:0] next_state;

  always @(posedge clk) begin
    if (load) begin
      state <= data;
    end else begin
      next_state <= state;
      for (int i = 0; i < 512; i++) begin
        next_state[i] = (state[i - 1] ^ state[i] ^ state[i + 1]);
      end
      state <= next_state;
    end
  end

  assign q = state;

endmodule