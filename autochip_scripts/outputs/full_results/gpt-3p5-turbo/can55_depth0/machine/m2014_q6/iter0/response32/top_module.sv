module top_module (
	input clk,
	input reset,
	input w,
	output z
);

  reg [2:0] state, next_state;
  wire clk_edge, reset_edge;

  assign clk_edge = (clk == 1'b1) && !($past(clk) == 1'b1);
  assign reset_edge = (reset == 1'b1) && !($past(reset) == 1'b1);

  always @(posedge clk)
  begin
    if (reset_edge)
      state <= 3'b000;
    else
      state <= next_state;
  end

  always @(state or w)
  begin
    case (state)
      3'b000: begin
        if (w == 1'b0)
          next_state = 3'b001;
        else
          next_state = 3'b000;
      end
      3'b001: begin
        if (w == 1'b0)
          next_state = 3'b010;
        else
          next_state = 3'b101;
      end
      3'b010: begin
        if (w == 1'b0)
          next_state = 3'b110;
        else
          next_state = 3'b011;
      end
      3'b011: begin
        if (w == 1'b0)
          next_state = 3'b010;
        else
          next_state = 3'b010;
      end
      3'b100: begin
        if (w == 1'b0)
          next_state = 3'b010;
        else
          next_state = 3'b011;
      end
      3'b101: begin
        if (w == 1'b0)
          next_state = 3'b010;
        else
          next_state = 3'b110;
      end
      default: next_state = 3'b000;
    endcase
  end

  always @(state)
  begin
    case (state)
      3'b100, 3'b101, 3'b110, 3'b111: z = 1'b1;
      default: z = 1'b0;
    endcase
  end
endmodule
