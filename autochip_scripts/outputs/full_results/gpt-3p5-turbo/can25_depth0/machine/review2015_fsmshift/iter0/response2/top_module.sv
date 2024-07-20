module top_module(
   input clk,
   input reset,
   output shift_ena,
   output reg [2:0] state);
 
   always @(posedge clk) begin
      if(reset) begin
         state <= 3'b000;
      end else begin
         case(state)
            3'b000: begin
               shift_ena <= 1;
               state <= 3'b001;
            end
            3'b001: begin
               shift_ena <= 1;
               state <= 3'b010;
            end
            3'b010: begin
               shift_ena <= 1;
               state <= 3'b011;
            end
            3'b011: begin
               shift_ena <= 1;
               state <= 3'b100;
            end
            default: begin
               shift_ena <= 0;
               state <= 3'b100;
            end
         endcase
      end
   end
 
endmodule
