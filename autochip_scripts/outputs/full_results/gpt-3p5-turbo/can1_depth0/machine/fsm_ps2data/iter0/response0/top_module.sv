module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg [23:0] out_bytes,
  output reg done
);
  
  parameter BYTE1 = 1'b0;
  parameter BYTE2 = 1'b1;
  parameter BYTE3 = 1'b2;
  parameter DONE = 1'b3;
  
  reg [1:0] state;
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      state <= BYTE1;
    else begin
      case (state)
        BYTE1: begin
          if (in[2] == 1'b1)
            state <= BYTE2;
          else
            state <= BYTE1;
        end
        BYTE2: begin
          state <= BYTE3;
        end
        BYTE3: begin
          state <= DONE;
        end
        DONE: begin
          if (in[2] == 1'b0)
            state <= BYTE1;
          else
            state <= DONE;
        end
        default: state <= BYTE1;
      endcase
    end
  end
  
  always @(posedge clk) begin
    if (done)
      out_bytes <= out_bytes;
    else
      out_bytes <= {in, out_bytes[23:8]};
  end
  
  always @(posedge clk) begin
    if (state == DONE)
      done <= 1'b1;
    else
      done <= 1'b0;
  end
  
endmodule
