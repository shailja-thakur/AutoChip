module top_module(
   input clk,
   input reset,
   input data,
   output reg shift_ena,
   output reg counting,
   input done_counting,
   output reg done,
   input ack );

   // Define states
   parameter IDLE = 0;
   parameter DETECT_PATTERN = 1;
   parameter WAIT_TIMER = 2;
   parameter NOTIFY_USER = 3;
   parameter WAIT_ACK = 4;

   // Define internal signals
   reg [1:0] state;
   reg [3:0] timer;

   // Initialize internal signals
   initial begin
      state = IDLE;
      timer = 0;
      shift_ena = 0;
      counting = 0;
      done = 0;
   end

   // State machine logic
   always @(posedge clk) begin
      if (reset) begin
         state <= IDLE;
         timer <= 0;
         shift_ena <= 0;
         counting <= 0;
         done <= 0;
      end else begin
         case (state)
            IDLE:
               if (data == 4'b1101) begin
                  state <= DETECT_PATTERN;
                  shift_ena <= 1;
               end else begin
                  state <= IDLE;
                  shift_ena <= 0;
               end
            DETECT_PATTERN:
               if (timer == 4'b1111) begin
                  state <= WAIT_TIMER;
                  shift_ena <= 0;
                  counting <= 1;
               end else begin
                  state <= DETECT_PATTERN;
                  timer <= timer + 1;
               end
            WAIT_TIMER:
               if (done_counting) begin
                  state <= NOTIFY_USER;
                  counting <= 0;
                  done <= 1;
               end else begin
                  state <= WAIT_TIMER;
               end
            NOTIFY_USER:
               if (ack) begin
                  state <= WAIT_ACK;
                  done <= 0;
               end else begin
                  state <= NOTIFY_USER;
               end
            WAIT_ACK:
               state <= (data == 4'b1101) ? DETECT_PATTERN : IDLE;
         endcase
      end
   end
endmodule
