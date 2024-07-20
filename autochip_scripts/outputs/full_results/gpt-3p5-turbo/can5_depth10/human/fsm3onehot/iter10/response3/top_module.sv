module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output reg out
);

// State transition logic
always @(*)
    case (state)
        4'b0001: if (in) begin
                      next_state = 4'b0010;  // A: next_state = B if in = 1
                  end else begin
                      next_state = 4'b0001;  // A: next_state = A if in = 0
                  end
        4'b0010: if (in) begin
                      next_state = 4'b0010;  // B: next_state = B if in = 1
                  end else begin
                      next_state = 4'b0100;  // B: next_state = C if in = 0
                  end
        4'b0100: if (in) begin
                      next_state = 4'b0001;  // C: next_state = A if in = 1
                  end else begin
                      next_state = 4'b1000;  // C: next_state = D if in = 0
                  end
        4'b1000: if (in) begin
                      next_state = 4'b0010;  // D: next_state = B if in = 1
                  end else begin
                      next_state = 4'b0100;  // D: next_state = C if in = 0
                  end
        default: next_state = 4'bzzzz;  // Default case, should not occur
    endcase

// Output logic
always @(*)
    case (state)
        4'b1000: out = 1'b1;  // Output is 1 only in state D
        default: out = 1'b0;
    endcase

endmodule
