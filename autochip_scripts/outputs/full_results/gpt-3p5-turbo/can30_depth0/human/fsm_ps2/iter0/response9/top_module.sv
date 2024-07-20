module top_module (
   input clk,
   input [7:0] in,
   input reset,
   output done
);

   reg [1:0] state;
   reg [7:0] byte_count;
   reg done_next;

   always @(posedge clk or posedge reset) begin
      if (reset) begin
         state <= 2'b00;
         byte_count <= 8'b0;
         done_next <= 1'b0;
      end else begin
         case (state)
            2'b00: begin
               if (in[3]) begin
                  byte_count <= 8'b1;
                  state <= 2'b01;
               end
            end
            2'b01: begin
               byte_count <= byte_count + 1;
               if (byte_count == 8'b111) begin
                  state <= 2'b10;
               end
            end
            2'b10: begin
               done_next <= 1'b1;
               state <= 2'b00;
            end
            default: state <= 2'b00;
         endcase
      end
   end

   assign done = done_next;

endmodule
