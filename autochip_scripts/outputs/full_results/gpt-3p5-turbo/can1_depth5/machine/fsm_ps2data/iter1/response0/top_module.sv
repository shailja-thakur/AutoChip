module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);

  // State declaration
  reg [1:0] state;
  
  // State machine transitions
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= 2'b00; // BYTE1
    else begin
      case (state)
        2'b00: begin // BYTE1
          if (in[2] == 1)
            state <= 2'b01; // BYTE2
          else
            state <= 2'b00; // BYTE1
        end
        2'b01: begin // BYTE2
          if (in[2] == 1)
            state <= 2'b10; // BYTE3
          else
            state <= 2'b00; // BYTE1
        end
        2'b10: begin // BYTE3
          state <= 2'b11; // DONE
        end
        2'b11: begin // DONE
          if (in[2] == 1)
            state <= 2'b01; // BYTE2
          else
            state <= 2'b00; // BYTE1
        end
      endcase
    end
  end

  // Output logic
  always @(posedge clk) begin
    if (reset)
      out_bytes <= 0;
    else if (state == 2'b11) // DONE
      out_bytes <= out_bytes;
    else
      out_bytes <= {out_bytes[15:0], in};
  end

  // Done signal logic
  always @(state) begin
    done = (state == 2'b11); // DONE
  end
  
endmodule
