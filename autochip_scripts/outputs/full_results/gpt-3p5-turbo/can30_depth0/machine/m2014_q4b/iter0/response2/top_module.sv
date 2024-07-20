module top_module (
	input clk,
	input d,
	input ar,
	output logic q
);

   // Register with asynchronous reset
   always @(posedge clk or posedge ar) begin
       if (ar) begin
           q <= 0;
       end else begin
           q <= d;
       end
   end
   
endmodule
