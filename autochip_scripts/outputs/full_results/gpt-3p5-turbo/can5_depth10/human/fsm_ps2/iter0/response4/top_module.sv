module top_module (
   input clk,
   input [7:0] in,
   input reset,
   output done
);

   // Define states
   parameter IDLE = 2'b00;
   parameter BYTE1 = 2'b01;
   parameter BYTE2 = 2'b10;
   parameter BYTE3 = 2'b11;
   
   // Define signals
   reg [1:0] state;
   reg done;
   reg [7:0] byte1;
   reg [7:0] byte2;
   reg [7:0] byte3;

   // Synchronous reset
   always @(posedge clk) begin
      if (reset) begin
         state <= IDLE;
         done <= 0;
         byte1 <= 0;
         byte2 <= 0;
         byte3 <= 0;
      end else begin
         // State transitions
         case (state)
            IDLE: begin
               if (in[3] == 1) begin
                  state <= BYTE1;
                  byte1 <= in;
               end
            end
            BYTE1: begin
               state <= BYTE2;
               byte2 <= in;
            end
            BYTE2: begin
               state <= BYTE3;
               byte3 <= in;
            end
            BYTE3: begin
               state <= IDLE;
               done <= 1;
            end
         endcase
      end
   end
   
   // Output assignment
   assign done = (state == IDLE) ? 0 : 1;

endmodule
