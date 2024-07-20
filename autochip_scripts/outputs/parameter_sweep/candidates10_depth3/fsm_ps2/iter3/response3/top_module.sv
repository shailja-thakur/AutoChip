module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

reg [2:0] state;
reg [7:0] byte1_reg, byte2_reg, byte3_reg;
reg [7:0] byte1_next, byte2_next, byte3_next;
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
        byte1_reg <= in;
        state <= 2;  // Transition to state 2
      end
      2: begin
        byte2_reg <= in;
        state <= 3;  // Transition to state 3
      end
      3: begin
        byte3_reg <= in;
        state <= 0;  // Transition back to state 0
      end
      default: state <= 0;
    endcase
  end
end

always @(posedge clk) begin
  if (reset)
    begin
      byte1_next <= 8'b0;
      byte2_next <= 8'b0;
      byte3_next <= 8'b0;
    end
  else begin
    byte1_next <= byte1_reg;
    byte2_next <= byte2_reg;
    byte3_next <= byte3_reg;
  end
end

assign done = (state == 3);

endmodule
