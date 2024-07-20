module top_module (
  input clk,
  input aresetn,
  input x,
  output reg z
);

// Define the states
typedef enum {S0, S1, S2} state_type;
reg [1:0] state, next_state;

// Define the output values
parameter IDLE = 0;
parameter DETECT = 1;
reg [0:0] output;

// Define the state transitions and outputs
always @(posedge clk or negedge aresetn) begin
  if (!aresetn) begin
    state <= S0;
    output <= IDLE;
  end
  else begin
    state <= next_state;
    output <= output;
  end
end

// Define the next state and output logic
always @(state or x) begin
  case (state)
    S0: begin
      if (x) begin
        next_state = S1;
        output = IDLE;
      end
      else begin
        next_state = S0;
        output = IDLE;
      end
    end
    S1: begin
      if (!x) begin
        next_state = S0;
        output = IDLE;
      end
      else begin
        next_state = S2;
        output = IDLE;
      end
    end
    S2: begin
      if (x) begin
        next_state = S1;
        output = DETECT;
      end
      else begin
        next_state = S0;
        output = IDLE;
      end
    end
    default: begin
      next_state = S0;
      output = IDLE;
    end
  endcase
end

// Assign the output signal
always @(posedge clk or negedge aresetn) begin
  if (!aresetn) begin
    z <= 0;
  end
  else begin
    if (state == S2 && output == DETECT) begin
      z <= 1;
    end
    else begin
      z <= 0;
    end
  end
end

endmodule
