module top_module (
	input clk,
	input areset,
	input x,
	output z
);

  // State enumeration
  typedef enum logic [1:0] {
    A,
    B
  } state_type;

  // State and next state variables
  state_type current_state;
  state_type next_state;

  // Outputs
  reg z;

  // Asynchronous reset to state A
  always @(posedge clk or posedge areset) begin
    if (areset) begin
      current_state <= A;
    end else begin
      current_state <= next_state;
    end
  end

  // State transition logic
  always @(*) begin
    case (current_state)
      A: begin
        if (x == 0) begin
          next_state = A;
          z = 0;
        end else begin
          next_state = B;
          z = 1;
        end
      end
      B: begin
        if (x == 0) begin
          next_state = B;
          z = 1;
        end else begin
          next_state = B;
          z = 0;
        end
      end
      default: begin
        next_state = A;
        z = 0;
      end
    endcase
  end

endmodule
