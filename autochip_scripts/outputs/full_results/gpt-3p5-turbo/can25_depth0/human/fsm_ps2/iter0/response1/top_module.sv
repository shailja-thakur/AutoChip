module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

reg [1:0] state;
reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;

always @(posedge clk) begin
  if (reset)
    state <= 0;
  else begin
    case (state)
      0: begin // IDLE state
        if (in[3] == 1)
          state <= 1; // Transition to RECEIVE_BYTE1 state
      end
      1: begin // RECEIVE_BYTE1 state
        byte1 <= in;
        state <= 2; // Transition to RECEIVE_BYTE2 state
      end
      2: begin // RECEIVE_BYTE2 state
        byte2 <= in;
        state <= 3; // Transition to RECEIVE_BYTE3 state
      end
      3: begin // RECEIVE_BYTE3 state
        byte3 <= in;
        state <= 0; // Transition to IDLE state
        done <= 1; // Signal that a message has been received
      end
    endcase
  end
end

endmodule
