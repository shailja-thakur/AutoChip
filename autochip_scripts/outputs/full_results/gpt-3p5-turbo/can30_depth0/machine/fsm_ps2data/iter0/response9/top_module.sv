module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg [23:0] out_bytes,
  output reg done
);

  // define states
  typedef enum logic [1:0] {
    BYTE1,
    BYTE2,
    BYTE3,
    DONE
  } state_type;

  // define current state
  reg state_type current_state, next_state;

  // define internal signals
  reg [2:0] input_bit;
  
  // always block for state transition and output assignment
  always @(posedge clk or posedge reset) begin
    if (reset)
      current_state <= BYTE1;
    else
      current_state <= next_state;
    end

  // always block for state transitions and output assignment
  always @(current_state or in) begin
    case (current_state)
      BYTE1:
        if (in[2]) // check third input bit
          next_state = BYTE2;
        else
          next_state = BYTE1;
      BYTE2:
        if (in[2])
          next_state = BYTE3;
        else
          next_state = BYTE1;
      BYTE3:
        if (in[2])
          next_state = DONE;
        else
          next_state = BYTE1;
      DONE:
        next_state = BYTE1;
    endcase
    done <= (current_state == DONE);
  end

  // always block for shifting input and assigning to out_bytes
  always @(posedge clk or posedge reset) begin
    if (reset)
      out_bytes <= 0;
    else begin
      out_bytes <= {out_bytes[15:0], in};
    end
  end

endmodule
