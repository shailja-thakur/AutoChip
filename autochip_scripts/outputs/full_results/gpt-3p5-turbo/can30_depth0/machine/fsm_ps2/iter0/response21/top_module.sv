module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg done
);
  
  // Define the states
  typedef enum logic [1:0] {
    BYTE1,
    BYTE2,
    BYTE3,
    DONE
  } state_t;
  
  // Declare state variable and initialize to BYTE1
  state_t state = BYTE1;
  
  always @(posedge clk or posedge reset)
  begin
    if (reset)
      state <= BYTE1;
    else
      case (state)
        BYTE1:
          if (in[2] == 1)
            state <= BYTE2;
        BYTE2:
          state <= BYTE3;
        BYTE3:
          state <= DONE;
        DONE:
          if (in[2] == 0)
            state <= BYTE1;
          else
            state <= BYTE2;
      endcase
  end
  
  // Output done signal when state is DONE
  assign done = (state == DONE);
  
endmodule
