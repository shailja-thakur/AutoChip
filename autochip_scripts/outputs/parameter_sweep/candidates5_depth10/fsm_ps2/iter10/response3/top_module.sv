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
   reg is_in_valid; // Changed from wire to reg

   always @(posedge clk or posedge reset) begin
      if (reset) begin
         state <= 0;
         count <= 0;
         is_in_valid <= 0; // Added reset value for is_in_valid
      end else begin
         case (state)
            0: begin
               if (is_first_byte) begin
                  state <= 1;
                  count <= 0;
                  is_in_valid <= 1;
               end
            end
            1: begin
               if (is_first_byte) begin
                  state <= 2;
                  count <= 0;
                  is_in_valid <= 1;
               end else begin
                  state <= 0;
                  count <= 0;
                  is_in_valid <= 0;
               end
            end
            2: begin
               if (is_first_byte) begin
                  state <= 1;
                  count <= count + 1;
                  is_in_valid <= 1;
               end else if (is_in_valid) begin // Removed check for is_in_valid falling edge
                  if (count == 1) begin
                     state <= 0;
                     count <= 0;
                  end else begin
                     count <= count + 1;
                  end
               end
            end
         endcase
         prev_in <= in;
      end
   end

   always @(posedge clk or posedge reset) begin
      if (reset) begin
         done <= 0;
      end else begin
         if (state == 2 && count == 1 && is_in_valid) begin
            done <= 1;
         end else begin
            done <= 0;
         end
      end
   end

endmodule
