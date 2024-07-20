module top_module(
   input wire clk,
   input wire reset,
   input wire data,
   output reg [3:0] count,
   output reg counting,
   output reg done,
   input wire ack );

   // Define the states for the state machine
   typedef enum logic [3:0] {
      IDLE,
      WAIT_FOR_PATTERN,
      SHIFT_IN_DELAY,
      COUNT
   } state_type;

   // Declare signal for the current state
   reg [3:0] state;

   // Declare signal for delay duration
   reg [3:0] delay;

   // Declare signal for counting duration
   reg [13:0] count_duration;

   // Declare signal for remaining time
   reg [3:0] remaining_time;

   // Declare signal to detect start pattern
   reg [3:0] pattern;

   // Assign initial values to the signals
   initial begin
      state = IDLE;
      count = 4'b0;
      counting = 0;
      done = 0;
      remaining_time = 4'b0;
   end

   // Assign next state based on current state
   always @(posedge clk or posedge reset) begin
      if (reset) begin
         state <= IDLE;
         delay <= 4'b0;
         count_duration <= 14'b0;
         pattern <= 4'b0;
      end else begin
         case(state)
            IDLE: begin
               if (data == 1'b1) begin
                  pattern <= {pattern[2:0], data};
                  if (pattern == 4'b1101) begin
                     state <= WAIT_FOR_PATTERN;
                     counting <= 0;
                     done <= 0;
                  end
               end
            end

            WAIT_FOR_PATTERN: begin
               if (data == 1'b0) begin
                  state <= SHIFT_IN_DELAY;
               end else if (data == 1'b1) begin
                  pattern <= {pattern[2:0], data};
                  if (pattern != 4'b1101) begin
                     state <= IDLE;
                     counting <= 0;
                     done <= 0;
                  end
               end
            end

            SHIFT_IN_DELAY: begin
               delay <= {delay[2:0], data};
               count_duration <= (delay + 1) * 14'd1000;
               state <= COUNT;
            end

            COUNT: begin
               remaining_time <= delay;
               if (count_duration > 0) begin
                  counting <= 1;
                  done <= 0;
                  count_duration <= count_duration - 1;
               end else begin
                  state <= IDLE;
                  counting <= 0;
                  done <= 1;
               end
            end
         endcase
      end
   end

   // Assign count output
   always @(negedge clk or posedge reset) begin
      if (reset) begin
         count <= 4'b0;
      end else if (state == COUNT) begin
         if (count_duration[9:0] == 10'd999) begin
            count <= delay - remaining_time + 4'b1;
         end
      end else begin
         count <= 4'b0;
      end
   end

   // Assert done when counting is done and wait for ack
   always @(negedge clk or posedge reset) begin
      if (reset) begin
         done <= 0;
      end else begin
         if (state == IDLE) begin
            done <= 0;
         end else if (state == COUNT) begin
            if (count_duration[9:0] == 10'd999) begin
               done <= 1;
            end
         end

         if (done && ack) begin
            state <= IDLE;
            counting <= 0;
            done <= 0;
         end
      end
   end
endmodule
