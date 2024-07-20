module top_module (
  input clk,
  input resetn,
  input in,
  output out
);

  reg [3:0] reg; // 4-bit shift register

  always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
      reg <= 4'b0; // reset the shift register to 0
    end else begin
      reg <= {reg[2:0], in}; // shift in the input value
    end
  end

  assign out = reg[3]; // output the most significant bit

endmodule
