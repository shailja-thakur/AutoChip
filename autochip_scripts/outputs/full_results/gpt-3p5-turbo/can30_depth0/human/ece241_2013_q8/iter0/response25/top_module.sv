module top_module (
  input clk,
  input aresetn,
  input x,
  output reg z
);

// Define states
typedef enum logic [1:0] {
  S0,
  S1,
  S2
} state_t;

// Define registers
reg [1:0] current_state;
reg [1:0] next_state;

// Define state transitions and outputs
always_ff @(posedge clk or negedge aresetn) begin
  if (~aresetn) begin
    current_state <= S0;
    z <= 0;
  end
  else begin
    current_state <= next_state;
    case (current_state)
      S0: begin
        if (x == 1'b1)
          next_state <= S1;
        else
          next_state <= S0;
      end
      S1: begin
        if (x == 1'b0)
          next_state <= S2;
        else
          next_state <= S1;
      end
      S2: begin
        if (x == 1'b1)
          next_state <= S1;
        else
          next_state <= S0;
      end
    endcase
    if (current_state == S1 && next_state == S2)
      z <= 1;
    else
      z <= 0;
  end
end

endmodule
