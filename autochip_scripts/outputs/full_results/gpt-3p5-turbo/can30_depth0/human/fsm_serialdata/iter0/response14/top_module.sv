module top_module (
  input clk,
  input in,
  input reset,
  output reg [7:0] out_byte,
  output reg done
);

  // Define the states of the FSM
  typedef enum logic [2:0] {
    IDLE,
    START_BIT,
    DATA_BITS,
    STOP_BIT
  } state_t;

  reg [2:0] state;
  reg [7:0] shift_reg;
  reg start_detected;

  // Synchronous reset
  always @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
      shift_reg <= 8'b0;
      out_byte <= 8'b0;
      done <= 0;
      start_detected <= 0;
    end else begin
      case (state)
        IDLE: begin
          if (in == 1'b0) begin
            state <= START_BIT;
            shift_reg <= 8'b0;
            start_detected <= 1;
          end
        end
        START_BIT: begin
          if (start_detected) begin
            state <= DATA_BITS;
            shift_reg[0] <= in;
          end
        end
        DATA_BITS: begin
          if (shift_reg[7:0] === 8'b0) begin
            shift_reg[7:1] <= shift_reg[6:0];
            shift_reg[0] <= in;
          end else begin
            state <= STOP_BIT;
          end
        end
        STOP_BIT: begin
          if (in == 1'b1) begin
            out_byte <= shift_reg;
            done <= 1;
            state <= IDLE;
          end
        end
      endcase
    end
  end

endmodule
