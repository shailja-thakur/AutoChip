module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output reg [23:0] out_bytes,
  output reg done
);

  // Define states
  parameter BYTE1 = 2'b00;
  parameter BYTE2 = 2'b01;
  parameter BYTE3 = 2'b10;
  parameter DONE = 2'b11;

  // Create state register
  reg [1:0] state;

  // Create temporary register for shifting
  reg [31:0] temp_reg;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= BYTE1;
      temp_reg <= 0;
      done <= 0;
    end else begin
      case (state)
        BYTE1: begin
          if (in[2] == 1) begin
            state <= BYTE2;
            temp_reg <= {temp_reg[23:0], in};
          end else begin
            state <= BYTE1;
            temp_reg <= {temp_reg[23:0], in};
          end
        end

        BYTE2: begin
          state <= BYTE3;
          temp_reg <= {temp_reg[23:0], in};
        end

        BYTE3: begin
          if (in[2] == 1) begin
            state <= DONE;
            temp_reg <= {temp_reg[23:0], in};
          end else begin
            state <= BYTE1;
            temp_reg <= {temp_reg[23:0], in};
          end
        end

        DONE: begin
          state <= BYTE1;
          temp_reg <= {temp_reg[23:0], in};
        end
      endcase
    end
  end

  always @(posedge clk) begin
    out_bytes <= temp_reg[23:0];
  end

  always @(posedge clk) begin
    if (state == DONE) begin
      done <= 1;
    end else begin
      done <= 0;
    end
  end

endmodule
