module top_module (
	input clk,
	input in,
	input reset,
	output out
);

  // State encoding
  typedef enum logic [1:0] {
    STATE_B = 2'b01,
    STATE_A = 2'b00
  } state_t;
    
  state_t state, next_state;

  // State transition logic
  always_ff @(posedge clk) begin
    if (reset) 
      state <= STATE_B;
    else 
      state <= next_state;
  end

  // Next state logic
  always_comb begin
    case (state)
      STATE_B: 
        if (in)
          next_state = STATE_B;
        else
          next_state = STATE_A;
    
      STATE_A:
        if (in)
          next_state = STATE_A;
        else
          next_state = STATE_B;

      default: 
        next_state = STATE_B;
    endcase
  end

  // Output logic
  assign out = (state == STATE_B) ? 1 : 0;

endmodule
