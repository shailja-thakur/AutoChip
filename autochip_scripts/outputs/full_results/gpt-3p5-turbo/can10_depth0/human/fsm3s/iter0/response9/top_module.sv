module top_module (
  input clk,
  input in,
  input reset,
  output reg out
);

// State enum
typedef enum logic [1:0] {
  A,
  B,
  C,
  D
} state_t;

// Registers for state and output
reg [1:0] curr_state, next_state;
reg curr_output;

// Next state and output logic
always @(posedge clk or posedge reset) begin
  if (reset) begin
    curr_state <= A;
    curr_output <= 0;
  end else begin
    curr_state <= next_state;
    curr_output <= (curr_state == D) ? 1 : 0;
  end
end

// Next state and output assignment
always @(*) begin
  case (curr_state)
    A: begin
        next_state = (in) ? B : A;
      end
    B: begin
        next_state = (in) ? B : C;
      end
    C: begin
        next_state = (in) ? D : A;
      end
    D: begin
        next_state = (in) ? B : C;
      end
  endcase
end

// Output assignment
assign out = curr_output;

endmodule
