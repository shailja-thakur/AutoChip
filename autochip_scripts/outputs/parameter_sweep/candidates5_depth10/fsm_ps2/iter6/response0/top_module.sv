module top_module (
   input clk,
   input [7:0] in,
   input reset,
   output reg done
);

   reg [2:0] state;
   reg [1:0] count;
   wire is_first_byte;
   reg [7:0] prev_in;

   assign is_first_byte = in[3];

   always @(posedge clk or posedge reset) begin
      if (reset) begin
         state <= 0;
         done <= 0;
         count <= 0;
         prev_in <= 0;
      end else begin
         case (state)
            0: begin
                  if (is_first_byte) begin
                     state <= 1;
                     count <= 1;
                     prev_in <= in;
                  end
               end
            1: begin
                  if (is_first_byte) begin
                     state <= 2;
                     count <= 2;
                  end else begin
                     state <= 0;
                     count <= 0;
                     prev_in <= in;
                  end
               end
            2: begin
                  if (is_first_byte) begin
                     state <= 1;
                     count <= 1;
                  end else begin
                     if (count == 2) begin
                        state <= 0;
                        count <= 0;
                        done <= 1;
                     end else begin
                        state <= 2;
                        count <= count + 1;
                     end
                  end
               end
         endcase
      end
   end

   always @(posedge clk) begin
      if (reset)
         done <= 0;
   end

endmodule
