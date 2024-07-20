module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);

  reg [1:0] state;
  reg [23:0] out_reg;
  wire next_state_en;

  // State register
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 2'b00;
    else if (next_state_en)
      state <= state + 1;
    else if (state == 2'b11 && done)
      state <= 2'b00;
  end

  // Next state logic
  always @(*) begin
    next_state_en = (state == 2'b00 && in[2] == 1'b1) ||
                    (state == 2'b01) ||
                    (state == 2'b10);
  end

  // Output register and done signal
  always @(posedge clk or posedge reset) begin
    if (reset)
      out_reg <= 24'b0;
    else if (done)
      out_reg <= out_reg;
    else
      out_reg <= {in, out_reg[23:8]};
  end

  // Output assignment
  assign out_bytes = out_reg;
  assign done = (state == 2'b11);

endmodule
