module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);
   
   reg [1:0] state;
   always @(posedge clk or posedge reset) begin
       if (reset) begin
           state <= 0;
       end else begin
           if (state == 0) begin
               if (j) begin
                   state <= 1;
               end else begin
                   state <= 0;
               end
           end else begin
               if (k) begin
                   state <= 0;
               end else begin
                   state <= 1;
               end
           end
       end
   end
   
   assign out = (state == 1) ? 1'b1 : 1'b0;
   
endmodule
