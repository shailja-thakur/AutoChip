module top_module (
   input clk,
   input [7:0] in,
   input reset,
   output reg done
);

   reg [2:0] state;
   reg [7:0] byte1;
   
   always @(posedge clk or posedge reset) begin
      if (reset) begin
         state <= 0;
         done <= 0;
         byte1 <= 0;
      end else begin
         case (state)
            0: begin
                  if (in[3] == 1) begin
                     byte1 <= in;
                     state <= 1;
                  end
               end
            1: begin
                  if (in[3] == 1) begin
                     byte1 <= in;
                     state <= 2;
                  end else
                     state <= 0;
               end
            2: begin
                  if (in[3] == 1) begin
                     byte1 <= in;
                     state <= 1;
                     done <= 1;
                  end else
                     state <= 0;
               end
         endcase
      end
   end

endmodule
