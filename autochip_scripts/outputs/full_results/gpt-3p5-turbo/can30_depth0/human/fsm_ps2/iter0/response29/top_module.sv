module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

  reg [7:0] byte1, byte2, byte3;
  reg [2:0] state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 0;
    end else begin
      case (state)
        0: begin  // Idle state
          if (in[3] == 1) begin
            byte1 <= in;
            state <= 1;
          end
        end

        1: begin  // Second byte state
          byte2 <= in;
          state <= 2;
        end

        2: begin  // Third byte state
          byte3 <= in;
          state <= 0;
          done <= 1;
        end
      endcase
    end
  end

endmodule
