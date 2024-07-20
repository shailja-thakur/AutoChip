module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);

  reg [7:0] byte1, byte2, byte3;
  reg [2:0] state;
  
  always @(posedge clk) begin
    if (reset) begin
      byte1 <= 8'b0;
      byte2 <= 8'b0;
      byte3 <= 8'b0;
      state <= 3'b0;
      out_bytes <= 24'b0;
      done <= 1'b0;
    end else begin
      case (state)
        3'b000: begin // State 0 (idle)
          byte1 <= in;
          if (in[3]) begin
            state <= 3'b001; // Go to State 1
          end
        end
        3'b001: begin // State 1
          byte2 <= in;
          state <= 3'b010; // Go to State 2
        end
        3'b010: begin // State 2
          byte3 <= in;
          state <= 3'b011; // Go to State 3
        end
        3'b011: begin // State 3
          out_bytes <= {byte1, byte2, byte3};
          state <= 3'b100; // Go to State 4
        end
        3'b100: begin // State 4
          done <= 1'b1;
          state <= 3'b000; // Go back to State 0
        end
        default: state <= 3'b000; // Default to State 0
      endcase
    end
  end
  
endmodule
