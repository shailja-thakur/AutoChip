module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

reg [2:0] state;
reg [7:0] byte1, byte2, byte3;
wire reset_done;

always @(posedge clk) begin
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
        state <= 0;  // Reset state
      end
      default: state <= 0;
    endcase
  end
end

assign done = reset_done;

always @(posedge clk or posedge reset) begin
  if (reset)
    reset_done <= 0;
  else begin
    if (state == 3 && byte1[in[3]] && byte2[in[3]] && byte3[in[3]])
      reset_done <= 1;
    else
      reset_done <= 0;
  end
end

endmodule
