module top_module (
  input clk,
  input in,
  input reset,
  output done
);

  // Define states
  typedef enum logic [2:0] {
    IDLE,
    START_BIT,
    DATA_BITS,
    STOP_BIT
  } state_t;

  // Define signals and variables
  logic [2:0] state;
  logic [7:0] data;
  logic start;
  logic stop;
  logic done_reg;

  // FSM logic
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
      done_reg <= 0;
      data <= 0;
    end else begin
      case (state)

        IDLE:
          if (in == 1'b0) begin
            state <= START_BIT;
            start <= 1'b1;
            data <= 0;
          end

        START_BIT:
          if (in == 1'b0) begin
            state <= DATA_BITS;
            start <= 1'b0;
            data <= {data[6:0], in};
          end else if (in == 1'b1) begin
            state <= IDLE;
          end

        DATA_BITS:
          if (in == 1'b0) begin
            data <= {data[6:0], in};
          end else if (in == 1'b1) begin
            state <= STOP_BIT;
            stop <= 1'b1;
          end

        STOP_BIT:
          if (in == 1'b1) begin
            state <= IDLE;
            stop <= 1'b0;
            done_reg <= 1'b1;
          end

      endcase
    end
  end

  // Output logic
  assign done = done_reg;

endmodule
