module top_module (
  input clk,
  input [7:0] in,
  input reset,
  output done
);

  // Declare the states as constants
  localparam BYTE1 = 2'b00;
  localparam BYTE2 = 2'b01;
  localparam BYTE3 = 2'b10;
  localparam DONE  = 2'b11;

  // Define the state register and next state logic
  reg [1:0] state_reg, state_next;
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state_reg <= BYTE1;
    end else begin
      state_reg <= state_next;
    end
  end

  // Define the logic for determining the next state
  always @(*) begin
    case (state_reg)
      BYTE1: begin
        if (in[2] == 1) begin
          state_next = BYTE2;
        end else begin
          state_next = BYTE1;
        end
      end
      BYTE2: begin
        state_next = BYTE3;
      end
      BYTE3: begin
        state_next = DONE;
      end
      DONE: begin
        if (in[2] == 1) begin
          state_next = BYTE2;
        end else begin
          state_next = BYTE1;
        end
      end
      default: begin
        state_next = BYTE1;
      end
    endcase
  end

  // Define the done signal logic
  assign done = (state_reg == DONE);

endmodule
