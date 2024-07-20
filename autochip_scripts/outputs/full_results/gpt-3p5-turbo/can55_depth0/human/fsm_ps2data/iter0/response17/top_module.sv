module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg [23:0] out_bytes,
  output reg done
);

reg [23:0] message;
reg [7:0] byte_count;
reg [7:0] state;

always @ (posedge clk) begin
  if (reset) begin
    message <= 24'b0;
    byte_count <= 8'b0;
    state <= 8'b0;
    done <= 1'b0;
  end else begin
    case (state)
      0: begin // Waiting for in[3] to be high
        if (in[3] == 1'b1) begin
          byte_count <= 8'b1;
          message[23:16] <= in;
          state <= 1;
        end
      end
      1: begin // Waiting for second byte
        byte_count <= byte_count + 1;
        message[15:8] <= in;
        if (byte_count == 8'b3) begin
          state <= 2;
        end
      end
      2: begin // Waiting for third byte
        byte_count <= byte_count + 1;
        message[7:0] <= in;
        state <= 3;
      end
      3: begin // Outputting message and setting done
        out_bytes <= message;
        done <= 1'b1;
        state <= 0;
      end
    endcase
  end
end

endmodule
