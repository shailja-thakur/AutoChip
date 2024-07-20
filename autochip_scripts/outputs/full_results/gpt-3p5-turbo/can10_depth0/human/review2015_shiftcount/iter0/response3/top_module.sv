module top_module(
  input clk,
  input shift_ena,
  input count_ena,
  input data,
  output reg [3:0] q);

  // Shift register and down counter
  reg [3:0] register;

  always @(posedge clk) begin
    if (shift_ena) begin
      register <= {data, register[3:1]};
    end
    else if (count_ena) begin
      register <= register - 1;
    end
  end

  assign q = register;

endmodule
