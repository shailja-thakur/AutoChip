module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

reg [2:0] state;
reg [7:0] byte1, byte2, byte3;

always @(posedge clk or posedge reset) begin
  if (reset)
    state <= 0;
  else begin
    case (state)
      0: begin
        if (in[3])
          state <= 1;  // First byte of a message
        else
          state <= 0;  // Discard byte
      end
      1: begin
        byte1 <= in;
        state <= 2;  // Second byte of a message
      end
      2: begin
        byte2 <= in;
        state <= 3;  // Third byte of a message
      end
      3: begin
        byte3 <= in;
        state <= 4;  // Wait for next cycle before resetting
      end
      4: begin
        state <= 0;  // Reset state
      end
      default: state <= 0;
    endcase
  end
end

assign done = (state == 3);

endmodule
