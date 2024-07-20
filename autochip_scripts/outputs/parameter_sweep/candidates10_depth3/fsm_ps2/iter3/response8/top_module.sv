module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

  reg [2:0] state;
  reg [7:0] byte1, byte2, byte3;
  reg is_byte_received;
  wire is_first_byte;

  assign is_first_byte = in[3] && (state == 0);

  always @(posedge clk) begin
    if (reset)
      state <= 0;
    else begin
      case (state)
        0: begin
          if (is_first_byte && is_byte_received)
            state <= 1;
        end
        1: begin
          byte1 = in;
          is_byte_received = 1;
          state <= 2;
        end
        2: begin
          byte2 = in;
          is_byte_received = 1;
          state <= 3;
        end
        3: begin
          byte3 = in;
          is_byte_received = 1;
          state <= 0;
        end
        default: state <= 0;
      endcase
    end
  end

  assign done = (state == 3);

endmodule
