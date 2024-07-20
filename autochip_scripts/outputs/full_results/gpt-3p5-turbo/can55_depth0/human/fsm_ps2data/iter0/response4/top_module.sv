module top_module (
   input clk,
   input [7:0] in,
   input reset,
   output [23:0] out_bytes,
   output done
);
   
   reg [1:0] state;
   reg [7:0] byte1;
   reg [7:0] byte2;
   reg [7:0] byte3;
   
   always @(posedge clk or posedge reset) begin
      if (reset) begin
         state <= 2'b00;
         byte1 <= 8'b0;
         byte2 <= 8'b0;
         byte3 <= 8'b0;
         done <= 0;
      end else begin
         case (state)
            2'b00: begin
               if (in[3] == 1) begin
                  state <= 2'b01;
                  byte1 <= in;
               end
            end
            2'b01: begin
               state <= 2'b10;
               byte2 <= in;
            end
            2'b10: begin
               state <= 2'b11;
               byte3 <= in;
            end
            2'b11: begin
               state <= 2'b00;
               done <= 1;
               out_bytes[23:16] <= byte1;
               out_bytes[15:8] <= byte2;
               out_bytes[7:0] <= byte3;
            end
         endcase
      end
   end
   
endmodule
