module top_module (
  input clk,
  input areset,
  input x,
  output reg z
);

// State declaration
reg [1:0] state;

// State definitions
parameter A = 2'b00;
parameter B = 2'b01;

// Next state logic
always @(posedge clk or posedge areset) begin
  if (areset) begin
    state <= A;
  end else begin
    case (state)
      A: begin
        if (x) begin
          state <= B;
        end else begin
          state <= A;
        end
      end
      B: begin
        if (x) begin
          state <= B;
        end else begin
          state <= A;
        end
      end
      default: state <= A; // Reset state if undefined state
    endcase
  end
end

// Output logic
always @(state) begin
  case (state)
    A: z <= 1'b0;
    B: z <= 1'b1;
    default: z <= 1'b0; // Reset output if undefined state
  endcase
end

endmodule
