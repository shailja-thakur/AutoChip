module top_module(
  input clk, 
  input load, 
  input [9:0] data, 
  output reg tc
);
  
  reg [9:0] counter;
  
  always @(posedge clk) begin
    if (load) begin
      counter <= data;
      tc <= 0; // Reset tc when load is asserted
    end else if (counter != 0) begin
      counter <= counter - 1;
      tc <= 0; // Reset tc when counter is decremented
    end else begin
      tc <= 1; // Set tc when counter reaches 0
    end
  end
  
endmodule
