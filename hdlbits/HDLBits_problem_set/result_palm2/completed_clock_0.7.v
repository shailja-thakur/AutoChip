module top_module (
  input wire clk,
  output wire [31:0] dut_out
);

  dut dut (clk);

  always @(posedge clk) begin
    dut_out <= dut.dut_out;
  end

endmodule