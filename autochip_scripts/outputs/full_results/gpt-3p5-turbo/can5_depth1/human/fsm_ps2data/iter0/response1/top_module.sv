module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);

  reg [1:0] state;
  reg [23:0] message;
  reg [7:0] byte_count;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 0;
      message <= 0;
      byte_count <= 0;
    end else begin
      case (state)
        0: begin
          if (in[3]) begin
            byte_count <= 1;
            message[23:16] <= in;
            state <= 1;
          end
        end
        1: begin
          byte_count <= byte_count + 1;
          message[15:8] <= in;
          state <= 2;
        end
        2: begin
          byte_count <= byte_count + 1;
          message[7:0] <= in;
          state <= 3;
        end
        3: begin
          byte_count <= byte_count + 1;
          done <= 1;
          out_bytes <= message;
          state <= 0;
        end
        default: state <= 0;
      endcase
    end
  end
endmodule
