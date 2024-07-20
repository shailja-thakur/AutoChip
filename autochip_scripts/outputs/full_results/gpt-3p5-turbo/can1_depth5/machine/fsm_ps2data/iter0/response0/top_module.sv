module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg [23:0] out_bytes,
  output reg done
);

  // State declaration
  reg [1:0] state;
  
  // State machine transitions
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= BYTE1;
    else begin
      case (state)
        BYTE1: begin
          if (in[2] == 1)
            state <= BYTE2;
          else
            state <= BYTE1;
        end
        BYTE2: begin
          if (in[2] == 1)
            state <= BYTE3;
          else
            state <= BYTE1;
        end
        BYTE3: begin
          state <= DONE;
        end
        DONE: begin
          if (in[2] == 1)
            state <= BYTE2;
          else
            state <= BYTE1;
        end
      endcase
    end
  end

  // Output logic
  always @(posedge clk) begin
    if (reset)
      out_bytes <= 0;
    else if (state == DONE)
      out_bytes <= out_bytes;
    else
      out_bytes <= {out_bytes[15:0], in};
  end

  // Done signal logic
  always @(state) begin
    done = (state == DONE);
  end
  
endmodule
