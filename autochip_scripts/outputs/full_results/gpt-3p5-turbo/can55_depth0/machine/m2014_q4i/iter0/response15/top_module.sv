module top_module(
	output reg out); // Added 'reg' datatype for output port
  	
  always @(*) // Added sensitivity list
    begin
      out = 0;
    end
  
endmodule
