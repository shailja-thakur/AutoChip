module top_module(
  input clk,
  input reset,
  output wire shift_ena);

  reg [3:0] pattern_count;
  reg [2:0] state;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      pattern_count <= 4'b0000;
      state <= 3'b000;
    end else begin
      case (state)
        3'b000:
          if (pattern_count == 4'b1101)
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
