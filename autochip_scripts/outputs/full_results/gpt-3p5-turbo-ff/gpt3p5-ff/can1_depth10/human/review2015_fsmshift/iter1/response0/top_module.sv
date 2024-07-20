module top_module(
  input clk,
  input reset,
  output wire shift_ena);

  parameter SHIFT_PATTERN = 4'b1101;

  reg [3:0] pattern_count;
  reg [2:0] state;
  
  always @(posedge clk) begin
    if (reset) begin
      pattern_count <= 4'b0000;
      state <= 3'b000;
    end else begin
      case (state)
        3'b000:
          if (pattern_count == SHIFT_PATTERN)
            state <= 3'b001;
          else
            pattern_count <= pattern_count + 1;
        3'b001:
          state <= 3'b010;
        3'b010:
          state <= 3'b011;
        3'b011:
          state <= 3'b000;
      endcase
    end
  end

  assign shift_ena = (state == 3'b010);
  
endmodule
