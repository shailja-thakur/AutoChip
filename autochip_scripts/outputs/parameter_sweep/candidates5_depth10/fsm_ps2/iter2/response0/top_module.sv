module top_module (
   input clk,
   input [7:0] in,
   input reset,
   output reg done
);

   reg [2:0] state;
   reg [1:0] count;
   wire is_first_byte;

   assign is_first_byte = in[3];

   always @(posedge clk or posedge reset) begin
      if (reset) begin
         state <= 0;
         done <= 0;
         count <= 0;
      end else begin
         case (state)
            0: begin
                  if (is_first_byte)
                     state <= 1;
                  else
                     state <= 0;
               end
            1: begin
                  if (is_first_byte)
                     state <= 2;
                  else
                     state <= 0;
               end
            2: begin
                  if (is_first_byte) begin
                     state <= 1;
                     count <= count + 1;
                  end
                  else if (count == 1) begin
                     state <= 0;
                     count <= 0;
                     done <= 1;
                  end
                  else begin
                     state <= 0;
                     count <= 0;
                  end
               end
         endcase
      end
   end

   always @(posedge clk or posedge reset) begin
      if (reset)
         done <= 0;
   end

endmodule
