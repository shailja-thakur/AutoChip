module top_module (
   input clk,
   input in,
   input reset,
   output out
);

   reg [1:0] state = 2'b0;
   reg out;
   
   always @(posedge clk or posedge reset) begin
      if(reset) begin
         state <= 2'b0;
         out <= 1;
      end
      else begin
         case(state)
            2'b00: begin  // state B
               if(in) begin
                  state <= 2'b00;
                  out <= 1;
               end
               else begin
                  state <= 2'b01;
                  out <= 0;
               end
            end
            2'b01: begin  // state A
               if(in) begin
                  state <= 2'b01;
                  out <= 0;
               end
               else begin
                  state <= 2'b00;
                  out <= 1;
               end
            end
         endcase
      end
   end
endmodule
