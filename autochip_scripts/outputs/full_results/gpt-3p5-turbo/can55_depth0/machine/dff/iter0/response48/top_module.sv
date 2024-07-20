module top_module(
  input clk,
  input d,
  output reg q
);

  reg [0:0] q; // Define the register signal q
  
  always @(posedge clk) begin // Triggered by the rising edge of the clock signal
    q <= d; // Set the register signal q to the value of the data signal d
  end

endmodule
