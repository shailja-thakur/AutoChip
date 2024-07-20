module top_module (
  input wire clk,
  input wire [7:0] in,
  input wire reset,
  output reg [23:0] out_bytes,
  output reg done
);

  // State declaration
  reg [1:0] state;
  reg [2:0] next_state;
  
  // State machine transitions
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 2'b00; // BYTE1
      out_bytes <= 0;
      done <= 0;
    end else begin
      state <= next_state;
    end
  end

  // Next state logic
  always @(state or in) begin
    case (state)
      2'b00: begin // BYTE1
        if (in[2] == 1)
          next_state <= 2'b01; // BYTE2
        else
          next_state <= 2'b00; // BYTE1
      end
      2'b01: begin // BYTE2
        if (in[2] == 1)
          next_state <= 2'b10; // BYTE3
        else
          next_state <= 2'b00; // BYTE1
      end
      2'b10: begin // BYTE3
        next_state <= 2'b11; // DONE
      end
      2'b11: begin // DONE
        if (in[2] == 1)
          next_state <= 2'b01; // BYTE2
        else
          next_state <= 2'b00; // BYTE1
      end
    endcase
  end

  // Output logic
  always @(posedge clk) begin
    if (reset)
      out_bytes <= 0;
    else if (state == 2'b11) // DONE
      out_bytes <= {out_bytes[15:0], in};
  end

  // Done signal logic
  always @(posedge clk) begin
    if (reset)
      done <= 0;
    else if (state == 2'b11) // DONE
      done <= 1;
    else
      done <= 0;
  end
  
endmodule
