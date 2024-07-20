module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

  // Define the states
  reg [1:0] state;
  localparam BYTE1 = 2'b00;
  localparam BYTE2 = 2'b01;
  localparam BYTE3 = 2'b10;
  localparam DONE = 2'b11;

  // Register to store the previous value of the third bit
  reg prev_bit3;

  // Default assignments
  always @(*) begin
    done = (state == DONE);
  end

  // State machine logic
  always @(posedge clk, posedge reset) begin
    if (reset) begin
      state <= BYTE1;
      prev_bit3 <= in[2];
    end
    else begin
      case (state)
        BYTE1: begin
          if (in[2] == 1'b1)
            state <= BYTE2;
          else
            state <= BYTE1;
          prev_bit3 <= in[2];
        end
        BYTE2: begin
          state <= BYTE3;
          prev_bit3 <= in[2];
        end
        BYTE3: begin
          state <= DONE;
          prev_bit3 <= in[2];
        end
        DONE: begin
          if (in[2] == 1'b1)
            state <= BYTE2;
          else
            state <= BYTE1;
          prev_bit3 <= in[2];
        end
      endcase
    end
  end

endmodule
