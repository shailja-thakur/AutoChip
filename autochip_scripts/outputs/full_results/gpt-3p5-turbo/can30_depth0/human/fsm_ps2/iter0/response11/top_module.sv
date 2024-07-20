module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);
  reg [2:0] state;
  reg [7:0] byte_count;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 0;
      byte_count <= 0;
      done <= 0;
    end
    else begin
      case (state)
        0: begin // Idle state
          if (in[3]) begin
            state <= 1;
            byte_count <= 1;
          end
        end
        1: begin // Receiving byte 1
          if (in[3]) begin
            state <= 2;
            byte_count <= 2;
          end
          else if (!in[3]) begin
            state <= 0;
            byte_count <= 0;
          end
        end
        2: begin // Receiving byte 2
          if (in[3]) begin
            state <= 3;
            byte_count <= 3;
          end
          else if (!in[3]) begin
            state <= 0;
            byte_count <= 0;
          end
        end
        3: begin // Receiving byte 3
          if (in[3]) begin
            state <= 0;
            byte_count <= 0;
            done <= 1;
          end
          else if (!in[3]) begin
            state <= 0;
            byte_count <= 0;
          end
        end
        default: begin
          state <= 0;
          byte_count <= 0;
        end
      endcase
    end
  end
endmodule
