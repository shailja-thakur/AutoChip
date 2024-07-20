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
    end else if (counter != 0) begin      // Use 'else if' instead of 'else' to fix counter decrementing
      counter <= counter - 1;
    end
    
    tc <= (counter == 1'b0);               // Change comparison to 1'b0 to fix comparison issue
  end
  
endmodule
