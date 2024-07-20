module top_module(
    input clk,
    input load,
    input [9:0] data,
    output tc
);
  
  reg [9:0] counter;
  wire tc;
  
  always @(posedge clk) begin
    if (load) begin
      counter <= data;
    end else begin
      if (counter != 0) begin
        counter <= counter - 1;
      end
    end
    
    tc <= (counter == 0);
  end
  
  assign tc = tc;
  
endmodule
