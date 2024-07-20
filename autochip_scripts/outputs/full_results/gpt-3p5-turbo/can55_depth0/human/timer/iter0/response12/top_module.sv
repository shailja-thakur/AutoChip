module top_module(
	input clk, 
	input load, 
	input [9:0] data, 
	output tc
);

   reg [9:0] internal_counter;
   
   always @(posedge clk) begin
      if (load) begin
         internal_counter <= data;
      end
      else if (internal_counter != 0) begin
         internal_counter <= internal_counter - 1;
      end
   end
   
   assign tc = (internal_counter == 0);
   
endmodule
