module top_module (
  input clk,
  input in,
  input reset,
  output reg [7:0] out_byte,
  output reg done
);

  // Define states
  typedef enum logic [2:0] {
    IDLE,
    START_BIT,
    RECEIVE_BITS,
    VERIFY_STOP_BIT
  } state_t;
  
  // Define signals
  reg [2:0] state;
  reg [2:0] next_state;
  reg [2:0] data_bits;
  reg start_bit_detected;
  reg stop_bit_detected;
  
  // Synchronous reset
  always @(posedge clk) begin
    if (reset) begin
      state <= IDLE;
      out_byte <= 8'b0;
      done <= 0;
      start_bit_detected <= 0;
      stop_bit_detected <= 0;
    end else begin
      state <= next_state;
      out_byte <= out_byte;
      done <= done;
      start_bit_detected <= start_bit_detected;
      stop_bit_detected <= stop_bit_detected;
    end
  end
  
  // State machine logic
  always @(*) begin
    next_state = state;
    
    case(state)
      IDLE:
        if (in == 1'b0) begin
          start_bit_detected = 1;
          next_state = START_BIT;
        end
      START_BIT:
        if (in == 1'b0) begin
          next_state = RECEIVE_BITS;
          data_bits = 0;
        end
      RECEIVE_BITS:
        if (in == 1'b1) begin
          data_bits = {data_bits[6:0], in};
          if (data_bits == 8'b01111110) begin
            stop_bit_detected = 1;
            next_state = VERIFY_STOP_BIT;
          end
        end
      VERIFY_STOP_BIT:
        if (in == 1'b1 && stop_bit_detected) begin
          done = 1;
          next_state = IDLE;
          out_byte = data_bits[7:0];
        end
    endcase
  end

endmodule
