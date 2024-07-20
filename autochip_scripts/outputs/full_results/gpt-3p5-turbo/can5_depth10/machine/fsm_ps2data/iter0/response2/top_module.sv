module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg [23:0] out_bytes,
  output reg done
);

  // Enumeration for the state machine
  typedef enum logic [1:0] {
    BYTE1,
    BYTE2,
    BYTE3,
    DONE
  } state_e;

  // Register to hold the current state
  reg [1:0] state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= BYTE1;
      done <= 0;
    end else begin
      case (state)
        BYTE1:
          if (in[2] == 1) begin
            state <= BYTE2;
          end else begin
            state <= BYTE1;
          end
        BYTE2:
          state <= BYTE3;
        BYTE3:
          state <= DONE;
        DONE:
          if (in[2] == 0) begin
            state <= BYTE1;
          end else begin
            state <= DONE;
          end
      endcase
    end
  end

  always @(posedge clk) begin
    if (done == 1) begin
      out_bytes <= {in, out_bytes[23:8]};
    end
  end

  assign done = (state == DONE);

endmodule
