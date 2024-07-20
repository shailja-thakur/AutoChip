module top_module (
  input clk,
  input reset,
  input s,
  input w,
  output reg z
);

// State enumeration
typedef enum logic [3:0] {
  A,
  B,
  C,
  S10,
  S11,
  S20,
  S21,
  S22
} state_e;

// State register
reg [3:0] state;

// Next state logic
always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= A;
  end else begin
    case (state)
      A: begin
        if (s) begin
          state <= B;
        end
      end
      B: begin
        if (w) begin
          state <= S11;
        end else begin
          state <= S10;
        end
      end
      C: begin
        if (w) begin
          state <= S11;
        end else begin
          state <= S10;
        end
      end
      S10: begin
        if (w) begin
          state <= S21;
        end else begin
          state <= S20;
        end
      end
      S11: begin
        if (w) begin
          state <= S22;
        end else begin
          state <= S21;
        end
      end
      S20: begin
        state <= B;
      end
      S21: begin
        if (w) begin
          state <= C;
        end else begin
          state <= B;
        end
      end
      S22: begin
        if (w) begin
          state <= B;
        end else begin
          state <= C;
        end
      end
    endcase
  end
end

// Output logic
always @(state) begin
  case (state)
    A: begin
      z <= 0;
    end
    B, C, S10, S11, S20, S21, S22: begin
      z <= 1;
    end
  endcase
end

endmodule
