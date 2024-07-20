module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

  reg [2:0] state;

  always @(posedge clk)
  begin
    if (reset)
      state <= 3'b000;
    else
    begin
      case (state)
        3'b000:
          if (in)
            state <= 3'b001;
          else
            state <= 3'b000;
        3'b001:
          if (in)
            state <= 3'b010;
          else
            state <= 3'b000;
        3'b010:
          if (in)
            state <= 3'b011;
          else
            state <= 3'b000;
        3'b011:
          if (in)
            state <= 3'b100;
          else
            state <= 3'b000;
        3'b100:
          if (in)
            state <= 3'b101;
          else
            state <= 3'b000;
        3'b101:
          if (in)
            state <= 3'b110;
          else
            state <= 3'b000;
        3'b110:
          if (in)
            state <= 3'b111;
          else
            state <= 3'b000;
        3'b111:
          if (in)
            state <= 3'b111;
          else
            state <= 3'b000;
      endcase
    end
  end

  always @(posedge clk)
  begin
    case (state)
      3'b000:
        begin
          disc <= 0;
          flag <= 0;
          err <= 0;
        end
      3'b001:
        begin
          disc <= 0;
          flag <= 0;
          err <= 0;
        end
      3'b010:
        begin
          disc <= 0;
          flag <= 0;
          err <= 0;
        end
      3'b011:
        begin
          disc <= 0;
          flag <= 0;
          err <= 0;
        end
      3'b100:
        begin
          disc <= 1;
          flag <= 0;
          err <= 0;
        end
      3'b101:
        begin
          disc <= 0;
          flag <= 1;
          err <= 0;
        end
      3'b110:
        begin
          disc <= 0;
          flag <= 0;
          err <= 1;
        end
      3'b111:
        begin
          disc <= 0;
          flag <= 0;
          err <= 1;
        end
    endcase
  end

endmodule
