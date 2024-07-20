module top_module(
  input clk,
  input d,
  output reg q
);

  reg q; // register signal

  initial begin
    q = 1'hx; // initialize register signal
  end

  always @(posedge clk) begin
    q <= d; // set register signal to data signal on rising edge of clock
  end

endmodule
