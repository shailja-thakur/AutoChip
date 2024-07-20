module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

  reg [1:0] state;
  always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
      state <= 2'b00;
    end else begin
      case (state)
        2'b00:
          if (x == 1'b1) begin
            state <= 2'b01;
          end else begin
            state <= 2'b00;
          end
        2'b01:
          if (x == 1'b0) begin
            state <= 2'b10;
          end else if (x == 1'b1) begin
            state <= 2'b01;
          end else begin
            state <= 2'b00;
          end
        2'b10:
          if (x == 1'b1) begin
            state <= 2'b01;
          end else begin
            state <= 2'b00;
          end
      endcase
    end
  end

  always @(state, x) begin
    case (state)
      2'b10:
        if (x == 1'b1) begin
          z <= 1'b1;
        end else begin
          z <= 1'b0;
        end
      default:
        z <= 1'b0;
    endcase
  end

endmodule
