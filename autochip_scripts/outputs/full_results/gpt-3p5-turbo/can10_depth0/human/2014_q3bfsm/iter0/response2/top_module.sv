module top_module (
  input clk,
  input reset,
  input x,
  output reg z
);

  reg [2:0] y_next;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      y_next <= 3'b000;
    end else begin
      case(y_next)
        3'b000: begin
          if(x) begin
            y_next <= 3'b001;
          end else begin
            y_next <= 3'b000;
          end
        end
        3'b001: begin
          if(x) begin
            y_next <= 3'b100;
          end else begin
            y_next <= 3'b001;
          end
        end
        3'b010: begin
          if(x) begin
            y_next <= 3'b001;
          end else begin
            y_next <= 3'b010;
          end
        end
        3'b011: begin
          if(x) begin
            y_next <= 3'b010;
          end else begin
            y_next <= 3'b001;
          end
        end
        3'b100: begin
          if(x) begin
            y_next <= 3'b100;
          end else begin
            y_next <= 3'b011;
          end
        end
        default: begin
          y_next <= 3'b000;
        end
      endcase
    end
  end

  always @(posedge clk) begin
    z <= (y_next[0] == 1) ? 1'b1 : 1'b0;
  end

endmodule
