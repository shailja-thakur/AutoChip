module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

reg [2:0] state;
reg [7:0] byte1, byte2, byte3;
wire is_first_byte;

assign is_first_byte = (in[3] == 1);

always @(posedge clk or posedge reset)
begin
  if (reset)
  begin
    state <= 0;
    byte1 <= 0;
    byte2 <= 0;
    byte3 <= 0;
  end
  else
  begin
    case (state)
      0:
        if (is_first_byte)
          state <= 1;  // First byte of a message
        else
          state <= 0;  // Discard byte
      1:
        begin
          byte1 <= in;
          state <= 2;  // Second byte of a message
        end
      2:
        begin
          byte2 <= in;
          state <= 3;  // Third byte of a message
        end
      3:
        begin
          byte3 <= in;
          state <= 0;  // Reset state
        end
    endcase
  end
end

assign done = (state == 3);

endmodule
