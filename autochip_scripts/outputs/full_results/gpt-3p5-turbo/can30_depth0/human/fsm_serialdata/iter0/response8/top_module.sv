module top_module (
  input clk,
  input in,
  input reset,
  output [7:0] out_byte,
  output done
);

  reg [7:0] data_reg;
  reg [2:0] state_reg;
  reg start_detected;
  reg stop_detected;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state_reg <= 0;
      start_detected <= 0;
      stop_detected <= 0;
    end else begin
      case (state_reg)
        0: begin  // Idle state
          if (!in) begin
            state_reg <= 1;  // Detected start bit
            start_detected <= 1;
          end
        end
        1: begin  // Start bit detected
          if (in) begin
            state_reg <= 2;  // Receiving data bits
            data_reg <= 0;
          end
        end
        2: begin  // Receiving data bits
          data_reg <= {data_reg[6:0], in};
          if (data_reg[7]) begin
            state_reg <= 3;  // Waiting for stop bit
          end
        end
        3: begin  // Waiting for stop bit
          if (!in) begin
            stop_detected <= 1;
          end else if (start_detected) begin  // Detected start bit before stop bit
            state_reg <= 0;
            start_detected <= 0;
          end else if (stop_detected) begin  // Detected consecutive stop bits
            data_reg <= 0;
            state_reg <= 0;
            stop_detected <= 0;
          end
        end
      endcase
    end
  end

  assign out_byte = data_reg;
  assign done = stop_detected;

endmodule
