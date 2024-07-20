module top_module (
   input clk,
   input areset,
   input bump_left,
   input bump_right,
   input ground,
   input dig,
   output walk_left,
   output walk_right,
   output aaah,
   output digging
);

   // Enumerate the states
   typedef enum logic[2:0] {
      STATE_WALK_LEFT,
      STATE_WALK_RIGHT,
      STATE_FALL,
      STATE_DIG,
      STATE_SPLATTER
   } state;

   // Define the current state and next state variables
   state current_state, next_state;

   // Define the state outputs
   logic walk_left_out, walk_right_out, aaah_out, digging_out;

   // Define the falling counter
   logic[4:0] fall_counter;

   // Define parameter for maximum fall cycles
   parameter MAX_FALL_CYCLES = 20;

   // Define the Moore state machine
   always_ff @(posedge clk or posedge areset) begin
      if (areset) begin
         current_state <= STATE_WALK_LEFT;
         fall_counter <= 0;
      end
      else begin
         current_state <= next_state;
         if (next_state != STATE_FALL) begin
            fall_counter <= 0;
         end
      end
   end

   // Define the next state logic
   always_comb begin
      case (current_state)
         STATE_WALK_LEFT:
            if (bump_right)
               next_state = STATE_WALK_RIGHT;
            else if (dig && ground)
               next_state = STATE_DIG;
            else if (!ground)
               next_state = STATE_FALL;
            else
               next_state = STATE_WALK_LEFT;
         STATE_WALK_RIGHT:
            if (bump_left)
               next_state = STATE_WALK_LEFT;
            else if (dig && ground)
               next_state = STATE_DIG;
            else if (!ground)
               next_state = STATE_FALL;
            else
               next_state = STATE_WALK_RIGHT;
         STATE_FALL:
            if (ground)
               next_state = current_state;
            else if (fall_counter == MAX_FALL_CYCLES)
               next_state = STATE_SPLATTER;
            else
               next_state = STATE_FALL;
         STATE_DIG:
            if (ground && !dig)
               next_state = current_state;
            else if (!ground)
               next_state = STATE_FALL;
            else
               next_state = STATE_DIG;
         STATE_SPLATTER:
            next_state = STATE_SPLATTER;
      endcase
   end

   // Define the state outputs
   always_comb begin
      case (current_state)
         STATE_WALK_LEFT:
            walk_left_out = 1;
            walk_right_out = 0;
            aaah_out = 0;
            digging_out = 0;
         STATE_WALK_RIGHT:
            walk_left_out = 0;
            walk_right_out = 1;
            aaah_out = 0;
            digging_out = 0;
         STATE_FALL:
            walk_left_out = 0;
            walk_right_out = 0;
            aaah_out = 1;
            digging_out = 0;
         STATE_DIG:
            walk_left_out = 0;
            walk_right_out = 0;
            aaah_out = 0;
            digging_out = 1;
         STATE_SPLATTER:
            walk_left_out = 0;
            walk_right_out = 0;
            aaah_out = 0;
            digging_out = 0;
         default:
            walk_left_out = 0;
            walk_right_out = 0;
            aaah_out = 0;
            digging_out = 0;
      endcase
   end

   // Assign outputs to state outputs
   assign walk_left = walk_left_out;
   assign walk_right = walk_right_out;
   assign aaah = aaah_out;
   assign digging = digging_out;

endmodule
