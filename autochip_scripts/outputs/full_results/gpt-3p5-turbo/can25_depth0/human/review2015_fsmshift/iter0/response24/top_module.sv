module top_module(
   input clk,
   input reset,
   output shift_ena);

   reg [2:0] state;
   reg [3:0] counter;

   parameter IDLE = 3'b000;
   parameter DETECT = 3'b001;
   parameter ENABLE = 3'b010;

   always @(posedge clk) begin
      if (reset) begin
         state <= IDLE;
         shift_ena <= 1'b0;
         counter <= 4'b1111;
      end else begin
         case (state)
            IDLE: begin
               if (|detect_pattern) begin
                  state <= DETECT;
                  shift_ena <= 1'b1;
                  counter <= 4'b1111;
               end
            end
            DETECT: begin
               if (counter == 4'b0000) begin
                  state <= ENABLE;
                  shift_ena <= 1'b0;
               end else begin
                  counter <= counter - 1;
               end
            end
            ENABLE: begin
               state <= IDLE;
               shift_ena <= 1'b0;
            end
         endcase
      end
   end

   function reg [3:0] detect_pattern;
      // Your bit pattern detection logic here
   endfunction

endmodule
