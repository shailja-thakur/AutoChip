module top_module(
    input clk,
    input [7:0] d,
    input areset,
    output reg [7:0] q); 

always @(posedge clk or posedge areset) // Added posedge for both clk and areset
   if(areset) begin  // Added begin and end
            q <= 8'b0;  // Updated 0 to 8'b0 for 8-bit value
   end else begin   // Added begin and end
            q <= d;
   end

endmodule
