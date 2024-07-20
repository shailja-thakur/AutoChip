module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

reg [2:0] state;
reg [7:0] byte1, byte2, byte3;
reg prev_is_first_byte; // New register to store previous value of is_first_byte

wire is_first_byte;


assign is_first_byte = in[3] && (state == 0);

always @(posedge clk) begin
  if (reset)
    state <= 0;
  else begin
    case (state)
      0: begin
        if (is_first_byte)
          state <= 1;  // Transition to state 1 if first byte
      end
      1: begin
        byte1 <= in;
        state <= 2;  // Transition to state 2
      end
      2: begin
        byte2 <= in;
        state <= 3;  // Transition to state 3
      end
      3: begin
        byte3 <= in;
        state <= 0;  // Transition back to state 0
      end
      default: state <= 0;
    endcase
  end
end

// Update prev_is_first_byte on every positive clock edge
always @(posedge clk) begin
  prev_is_first_byte <= is_first_byte;
end

// Output done only in the cycle immediately after the third byte of each message was successfully received
assign done = (state == 0 && prev_is_first_byte);

endmodule
