module top_module (
	input clk,
	input reset,
	input w,
	output z
);

  reg [2:0] state;
  reg z;

  always @(posedge clk) begin
    if (reset) begin
      state <= 3'b000;
    end else begin
      case (state)
        3'b000: begin
          if (w) begin
            state <= 3'b000;
          end else begin
            state <= 3'b001;
          end
        end
        3'b001: begin
          if (w) begin
            state <= 3'b000;
          end else begin
            state <= 3'b010;
          end
        end
        3'b010: begin
          if (w) begin
            state <= 3'b011;
          end else begin
            state <= 3'b100;
          end
        end
        3'b011: begin
          if (w) begin
            state <= 3'b000;
          end else begin
            state <= 3'b101;
          end
        end
        3'b100: begin
          if (w) begin
            state <= 3'b011;
          end else begin
            state <= 3'b110;
          end
        end
        3'b101: begin
          if (w) begin
            state <= 3'b011;
          end else begin
            state <= 3'b101;
          end
        end
        3'b110: begin
          if (w) begin
            state <= 3'b011;
          end else begin
            state <= 3'b110;
          end
        end
      endcase
    end
  end

  always @(state) begin
    if (state == 3'b101 || state == 3'b110) begin
      z <= 1'b1;
    end else begin
      z <= 1'b0;
    end
  end

endmodule
