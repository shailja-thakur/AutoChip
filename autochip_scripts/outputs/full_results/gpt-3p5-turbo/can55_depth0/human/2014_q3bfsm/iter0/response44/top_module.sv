module top_module (
  input clk,
  input reset,
  input x,
  output reg z
);

  reg [2:0] y;
  always @(posedge clk, posedge reset) begin
    if (reset) begin
      y <= 3'b000; // reset to state 000
    end else begin
      case (y)
        3'b000: begin
          if (x) begin
            y <= 3'b001;
          end else begin
            y <= 3'b000;
          end
        end
      3'b001: begin
          if (x) begin
            y <= 3'b100;
          end else begin
            y <= 3'b001;
          end
        end
        3'b010: begin
          if (x) begin
            y <= 3'b001;
          end else begin
            y <= 3'b010;
          end
        end
        3'b011: begin
          if (x) begin
            y <= 3'b010;
          end else begin
            y <= 3'b001;
          end
        end
        3'b100: begin
          if (x) begin
            y <= 3'b100;
          end else begin
            y <= 3'b011;
          end
        end
      endcase
    end
  end

  always @(posedge clk) begin
    case (y)
      3'b011:
        z <= 1'b1;
      3'b100:
        z <= 1'b1;
      default:
        z <= 1'b0;
    endcase
  end

endmodule
