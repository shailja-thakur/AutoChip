module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

  typedef enum reg [1:0] {
    S0, // Initial state
    S1  // Complement state
  } state_t;
  
  state_t state, next_state;
  reg complement;

  // State transition
  always @(posedge clk or posedge areset) begin
    if (areset)
      state <= S0;
    else
      state <= next_state;
  end

  // Next state logic
  always @(*) begin
    case (state)
      S0: begin
        if (x == 1'b1) 
          next_state = S1;
        else
          next_state = S0;
      end
      S1: next_state = S1;
      default: next_state = S0;
    endcase
  end

  // Output logic
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      z <= 1'b0;
      complement <= 1'b1;
    end else begin
      case (state)
        S0: begin
          z <= x;
          complement <= 1'b1;
        end
        S1: begin
          z <= x ^ complement;
          if (x == 1'b0) 
            complement <= 1'b0;
        end
      endcase
    end
  end

endmodule
