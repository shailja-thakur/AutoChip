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

// Define the states
typedef enum logic [2:0] {
  STATE_WALK_LEFT,
  STATE_WALK_RIGHT,
  STATE_FALL,
  STATE_DIG
} state_type;

// Define the inputs
typedef struct packed {
  logic reset;
  logic bump_left;
  logic bump_right;
  logic ground;
  logic dig;
} input_type;

// Define the outputs
typedef struct packed {
  logic walk_left;
  logic walk_right;
  logic aaah;
  logic digging;
} output_type;

// Define the state machine
typedef struct packed {
  state_type next_state;
  output_type output;
} state_machine_type;

// Define the state transition function
function state_machine_type state_transition(input_type inputs, state_type current_state);
  state_machine_type next_state_machine;

  case (current_state)
    STATE_WALK_LEFT:
      if (inputs.bump_left)
        next_state_machine.next_state = STATE_WALK_RIGHT;
      else if (!inputs.ground)
        next_state_machine.next_state = STATE_FALL;
      else if (inputs.dig)
        next_state_machine.next_state = STATE_DIG;
      else
        next_state_machine.next_state = STATE_WALK_LEFT;
        
      if (inputs.bump_right || !inputs.ground || (inputs.dig && !inputs.ground))
        next_state_machine.output.aaah = 1;
      else
        next_state_machine.output.aaah = 0;
      
      next_state_machine.output.walk_left = 1;
      next_state_machine.output.walk_right = 0;
      next_state_machine.output.digging = 0;
    STATE_WALK_RIGHT:
      if (inputs.bump_right)
        next_state_machine.next_state = STATE_WALK_LEFT;
      else if (!inputs.ground)
        next_state_machine.next_state = STATE_FALL;
      else if (inputs.dig)
        next_state_machine.next_state = STATE_DIG;
      else
        next_state_machine.next_state = STATE_WALK_RIGHT;
        
      if (inputs.bump_left || !inputs.ground || (inputs.dig && !inputs.ground))
        next_state_machine.output.aaah = 1;
      else
        next_state_machine.output.aaah = 0;
      
      next_state_machine.output.walk_left = 0;
      next_state_machine.output.walk_right = 1;
      next_state_machine.output.digging = 0;
    STATE_FALL:
      if (inputs.ground)
        next_state_machine.next_state = current_state; // Stay in the same state
      else if (inputs.dig && inputs.ground)
        next_state_machine.next_state = STATE_DIG;
      else if (inputs.bump_left || inputs.bump_right || (inputs.dig && !inputs.ground))
        next_state_machine.next_state = current_state; // Stay in the same state
      else
        next_state_machine.next_state = STATE_FALL;
      
      if (!inputs.ground)
        next_state_machine.output.aaah = 1;
      else
        next_state_machine.output.aaah = 0;
      
      next_state_machine.output.walk_left = 0;
      next_state_machine.output.walk_right = 0;
      next_state_machine.output.digging = 0;
    STATE_DIG:
      if (!inputs.ground)
        next_state_machine.next_state = STATE_FALL;
      else if (!inputs.dig)
        next_state_machine.next_state = current_state; // Stay in the same state
      else
        next_state_machine.next_state = STATE_DIG;
      
      if (inputs.bump_left || inputs.bump_right || !inputs.ground)
        next_state_machine.output.aaah = 1;
      else
        next_state_machine.output.aaah = 0;
      
      next_state_machine.output.walk_left = current_state == STATE_WALK_LEFT;
      next_state_machine.output.walk_right = current_state == STATE_WALK_RIGHT;
      next_state_machine.output.digging = 1;
  endcase
  
  return next_state_machine;
endfunction

reg [2:0] current_state;
reg aaah;

always @(posedge clk, posedge areset)
begin
  if (areset)
  begin
    current_state <= STATE_WALK_LEFT;
    aaah <= 0;
  end
  else
  begin
    state_machine_type current_state_machine;
    input_type inputs;
    output_type outputs;
    
    inputs.reset = 0;
    inputs.bump_left = bump_left;
    inputs.bump_right = bump_right;
    inputs.ground = ground;
    inputs.dig = dig;
    
    current_state_machine = state_transition(inputs, current_state);
    
    current_state <= current_state_machine.next_state;
    aaah <= current_state_machine.output.aaah;
    
    outputs = current_state_machine.output;
    walk_left = outputs.walk_left;
    walk_right = outputs.walk_right;
    aaah = outputs.aaah;
    digging = outputs.digging;
  end
end

endmodule
