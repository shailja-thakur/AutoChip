module top_module(
  input clk,
  input load,
  input [9:0] data,
  output tc
);
  
  reg [9:0] counter; // declare a register to hold the counter value
  
  always @(posedge clk) begin
    if (load) // check if the load signal is asserted
      counter <= data; // load the counter with the new value from the data port
    else if (counter != 10'b0) // check if the counter is not already at 0
      counter <= counter - 1; // decrement the counter by 1
    
    tc <= (counter == 10'b0); // set tc to 1 if the counter value is 0, otherwise set it to 0
  end
  
endmodule
