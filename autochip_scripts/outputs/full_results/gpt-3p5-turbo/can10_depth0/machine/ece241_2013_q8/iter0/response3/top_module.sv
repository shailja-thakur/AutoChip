module top_module (
  input clk,
  input aresetn,
  input x,
  output reg z
);

// Define states using parameters
parameter S = 2'b00;
parameter S1 = 2'b01;
parameter S10 = 2'b10;

// Define state and next_state registers
reg [1:0] state, next_state;

// Initialize state and next_state registers
always @(posedge clk or negedge aresetn) begin
  if (~aresetn) begin
    state <= S;
    next_state <= S;
  end else begin
    state <= next_state;
  end
end

// Define next_state logic based on input x and current state
always @(*) begin
  case (state)
    S: begin
      if (x == 1'b1)
        next_state = S1;
      else
        next_state = S;
    end
    S1: begin
      if (x == 1'b1)
        next_state = S1;
      else
        next_state = S10;
    end
    S10: begin
      if (x == 1'b1)
        next_state = S1;
      else
        next_state = S;
    end
  endcase
end

// Define output z based on current state
always @(state) begin
  case (state)
    S, S1: z <= 1'b0;
    S10: z <= x;
  endcase
end

endmodule
