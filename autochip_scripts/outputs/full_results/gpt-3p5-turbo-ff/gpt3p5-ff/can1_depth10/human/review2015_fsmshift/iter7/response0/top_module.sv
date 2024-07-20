module top_module(
  input clk,
  input reset,
  output wire shift_ena);

  reg [3:0] pattern_count;
  reg [2:0] state;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      pattern_count <= 0;
      state <= 0;
    end else begin
      case (state)
        0:
          begin
            if (pattern_count == 4'b1101)
              state <= 1;
            else
              pattern_count <= pattern_count + 1;
          end
        1:
          state <= 2;
        2:
          state <= 3;
        3:
          state <= 0;
      endcase
    end
  end

  assign shift_ena = (state == 2);
  
endmodule
