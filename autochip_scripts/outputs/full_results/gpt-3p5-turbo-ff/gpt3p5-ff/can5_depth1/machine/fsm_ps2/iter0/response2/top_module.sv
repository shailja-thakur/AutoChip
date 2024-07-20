module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

  // state encoding
  parameter BYTE1 = 2'b00;
  parameter BYTE2 = 2'b01;
  parameter BYTE3 = 2'b10;
  parameter DONE = 2'b11;

  // state register
  reg [1:0] state_reg;
  // next state
  reg [1:0] state_next;

  // combinational logic for next state and output
  always @(*) begin
    state_next = state_reg;
    done = 0;
    case (state_reg)
      BYTE1: begin
        if (in[2] == 1)
          state_next = BYTE2;
      end
      BYTE2: begin
        state_next = BYTE3;
      end
      BYTE3: begin
        state_next = DONE;
      end
      DONE: begin
        if (in[2] == 0)
          state_next = BYTE1;
        else
          state_next = BYTE2;
      end
    endcase
    if (state_reg == DONE)
      done = 1;
  end

  // sequential logic
  always @(posedge clk or posedge reset) begin
    if (reset)
      state_reg <= BYTE1;
    else
      state_reg <= state_next;
  end

endmodule
