module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);

   reg out_internal;
   reg [1:0] state;
   parameter OFF = 2'b00;
   parameter ON = 2'b01;
   
   always @(posedge clk or posedge reset) begin
       if (reset) begin
           state <= OFF;
           out_internal <= 0;
       end else begin
           case(state)
               OFF: begin
                   if(j) begin
                       state <= ON;
                       out_internal <= 1;
                   end
               end
               ON: begin
                   if(k) begin
                       state <= OFF;
                       out_internal <= 0;
                   end
               end
           endcase
       end
   end

   assign out = out_internal;

endmodule
