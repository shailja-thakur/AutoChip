module top_module (
   input clk,
   input [7:0] in,
   input reset,
   output reg [23:0] out_bytes,
   output reg done
);

   // Declare state register
   reg [1:0] state;

   always @(posedge clk or posedge reset) begin
      if (reset)                 // Reset state machine
         state <= 2'b00;
      else begin
         case (state)
            2'b00: begin         // BYTE1 state
               if (in[2] == 1)
                  state <= 2'b01; // Transition to BYTE2 if third bit is 1
               else
                  state <= 2'b00; // Stay in BYTE1 if third bit is 0
            end

            2'b01: begin         // BYTE2 state
               state <= 2'b10;    // Transition to BYTE3
            end

            2'b10: begin         // BYTE3 state
               state <= 2'b11;    // Transition to DONE
            end

            2'b11: begin         // DONE state
               if (in[2] == 0)
                  state <= 2'b00; // Transition to BYTE1 if third bit is 0
               else
                  state <= 2'b11; // Stay in DONE if third bit is 1
            end
         endcase
      end
   end

   // Update out_bytes register on rising edge of clock
   always @(posedge clk or posedge reset) begin
      if (reset)                      // Reset out_bytes register
         out_bytes <= 24'b0;
      else if (state == 2'b11) begin  // Set out_bytes output when in DONE state
         out_bytes <= {out_bytes[15:0], in};  // Shift register and append input
      end
   end

   // Set done output when in DONE state
   always @(state) begin
      if (state == 2'b11)
         done <= 1'b1;
      else
         done <= 1'b0;
   end

endmodule
