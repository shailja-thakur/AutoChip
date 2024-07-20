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
    end else if (counter != 0) begin
      counter <= counter - 1;
    end
  end
  
  always @(counter) begin                 // Add sensitivity list for 'counter' change
    tc <= (counter == 10'b0);              // Change comparison to 10'b0 to match counter width
  end
  
endmodule
