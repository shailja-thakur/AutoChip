module top_module (
  input clk,
  input areset,
  input x,
  output reg z
);

  reg [2:0] state = 3'b000;
  
  always @(posedge clk, negedge areset) begin
    if (areset == 0) begin
      state <= 3'b000;
      z <= 0;
    end
    else begin
      case (state)
        3'b000: begin
          if (x == 1'b1)
            state <= 3'b001;
        end
        3'b001: begin
          if (x == 1'b0)
            state <= 3'b010;
        end
        3'b010: begin
          if (x == 1'b1) begin
            state <= 3'b010;
            z <= ~z;
          end
          else if (x == 1'b0)
            state <= 3'b011;
        end
        3'b011: begin
          state <= 3'b100;
          z <= ~z;
        end
        default: begin
          state <= 3'b000;
        end
      endcase
    end
  end

endmodule
