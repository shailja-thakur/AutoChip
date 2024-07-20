module top_module (
  input clk,
  input reset,
  input in,
  output disc,
  output flag,
  output err);

  // Define states
  typedef enum logic [2:0] {
    S0,
    S1,
    S2,
    S3,
    S4,
    S5,
    S6,
    S7
  } state_t;

  // Define signals
  state_t state;
  state_t next_state;
  logic previous_input;
  logic discard;
  logic frame_flag;
  logic error_flag;

  always @(posedge clk) begin
    if (reset) begin
      state <= S0;
      previous_input <= 1'b0;
      discard <= 1'b0;
      frame_flag <= 1'b0;
      error_flag <= 1'b0;
    end else begin
      state <= next_state;
      previous_input <= in;
      discard <= 1'b0;
      frame_flag <= 1'b0;
      error_flag <= 1'b0;

      case (state)
        S0:
          if (in) begin
            next_state <= S1;
            discard <= 1'b0;
            frame_flag <= 1'b0;
            error_flag <= 1'b0;
          end else begin
            next_state <= S0;
            discard <= 1'b0;
            frame_flag <= 1'b0;
            error_flag <= 1'b0;
          end
        S1:
          if (in) begin
            next_state <= S2;
            discard <= 1'b0;
            frame_flag <= 1'b0;
            error_flag <= 1'b0;
          end else begin
            next_state <= S0;
            discard <= 1'b0;
            frame_flag <= 1'b0;
            error_flag <= 1'b0;
          end
        S2:
          if (in) begin
            next_state <= S3;
            discard <= 1'b0;
            frame_flag <= 1'b0;
            error_flag <= 1'b0;
          end else begin
            next_state <= S0;
            discard <= 1'b0;
            frame_flag <= 1'b0;
            error_flag <= 1'b0;
          end
        S3:
          if (in) begin
            next_state <= S4;
            discard <= 1'b0;
            frame_flag <= 1'b0;
            error_flag <= 1'b0;
          end else begin
            next_state <= S0;
            discard <= 1'b0;
            frame_flag <= 1'b0;
            error_flag <= 1'b0;
          end
        S4:
          if (in) begin
            next_state <= S5;
            discard <= 1'b0;
            frame_flag <= 1'b0;
            error_flag <= 1'b0;
          end else begin
            next_state <= S0;
            discard <= 1'b0;
            frame_flag <= 1'b0;
            error_flag <= 1'b0;
          end
        S5:
          if (in) begin
            next_state <= S6;
            discard <= 1'b0;
            frame_flag <= 1'b0;
            error_flag <= 1'b0;
          end else begin
            next_state <= S0;
            discard <= 1'b0;
            frame_flag <= 1'b0;
            error_flag <= 1'b0;
          end
        S6:
          if (in) begin
            next_state <= S7;
            discard <= 1'b0;
            frame_flag <= 1'b0;
            error_flag <= 1'b0;
          end else begin
            next_state <= S0;
            discard <= 1'b0;
            frame_flag <= 1'b0;
            error_flag <= 1'b0;
          end
        S7:
          if (in) begin
            next_state <= S7;
            discard <= 1'b0;
            frame_flag <= 1'b1;
            error_flag <= 1'b1;
          end else begin
            next_state <= S0;
            discard <= 1'b1;
            frame_flag <= 1'b0;
            error_flag <= 1'b0;
          end
      endcase
    end
  end

  // Assign output signals
  assign disc = discard;
  assign flag = frame_flag;
  assign err = error_flag;
endmodule
