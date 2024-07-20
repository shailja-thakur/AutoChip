module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output [23:0] out_bytes,
  output done
);

reg [1:0] state;
reg [23:0] message;

always @(posedge clk or posedge reset) begin
  if (reset)
    state <= 2'b00;
  else begin
    case (state)
      2'b00: begin  // Discard bytes until in[3] == 1
        if (in[3] == 1)
          state <= 2'b01;
      end
      2'b01: begin  // Received byte 1 of the message
        state <= 2'b10;
        message[23:16] <= in;
      end
      2'b10: begin  // Received byte 2 of the message
        state <= 2'b11;
        message[15:8] <= in;
      end
      2'b11: begin  // Received byte 3 of the message
        state <= 2'b00;
        message[7:0] <= in;
        out_bytes <= message;
        done <= 1;
      end
    endcase
  end
end

endmodule
