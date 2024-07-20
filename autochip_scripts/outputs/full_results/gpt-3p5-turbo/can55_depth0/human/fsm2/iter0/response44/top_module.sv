module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

  reg [1:0] state;
  reg out;

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= 2'b0;
      out <= 1'b0;
    end else begin
      case (state)
        2'b00: begin
          if (j) state <= 2'b01;
        end
        2'b01: begin
          if (k) state <= 2'b00;
        end
      endcase
    end
  end

  always @(state) begin
    case (state)
      2'b00: out <= 1'b0;
      2'b01: out <= 1'b1;
      default: out <= 1'b0;
    endcase
  end

endmodule
