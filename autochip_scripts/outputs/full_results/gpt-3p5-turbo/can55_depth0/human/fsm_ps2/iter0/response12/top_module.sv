module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

reg [7:0] first_byte;
reg [7:0] second_byte;
reg [7:0] third_byte;
reg [2:0] state;

always @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= 0;
    first_byte <= 0;
    second_byte <= 0;
    third_byte <= 0;
  end else begin
    case(state)
      0: begin // Initial state, waiting for first byte with in[3]=1
        if (in[3]) begin
          first_byte <= in;
          state <= 1;
        end
      end
      1: begin // Waiting for second byte
        second_byte <= in;
        state <= 2;
      end
      2: begin // Waiting for third byte
        third_byte <= in;
        state <= 3;
      end
      3: begin // Received all three bytes, message complete
        done <= 1;
        state <= 0; // Resetting state for next message
      end
    endcase
  end
end

endmodule
