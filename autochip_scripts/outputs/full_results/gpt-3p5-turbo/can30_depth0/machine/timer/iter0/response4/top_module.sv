module top_module(
  input clk,
  input load,
  input [9:0] data,
  output tc
);

  reg [9:0] counter; // declares a 10-bit register for the counter

  always @(posedge clk) begin // triggers on the rising edge of the clk signal
    if (load) begin // checks if the load signal is asserted
      counter <= data; // loads the counter with the value from the data signal
    end else if (counter != 0) begin // checks if the counter is not already at 0
      counter <= counter - 1; // decrements the counter by 1
    end
    tc <= (counter == 0); // assigns tc to the comparison result between the counter value and 0
  end

endmodule
