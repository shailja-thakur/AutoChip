module top_module (
  input clk,
  input resetn,
  input [3:1] r,
  output [3:1] g
);

  reg [1:0] state;

  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      state <= 2'b00;
    end else begin
      case (state)
        2'b00: begin
          if (r[1] == 1'b1) begin
            state <= 2'b01;
          end else if (r[2] == 1'b1) begin
            state <= 2'b10;
          end else if (r[3] == 1'b1) begin
            state <= 2'b11;
          end else begin
            state <= 2'b00;
          end
        end
        2'b01: begin
          if (g[1] == 1'b1 && r[1] == 1'b1) begin
            state <= 2'b01;
          end else begin
            state <= 2'b00;
          end
        end
        2'b10: begin
          if (g[2] == 1'b1 && r[2] == 1'b1) begin
            state <= 2'b10;
          end else begin
            state <= 2'b00;
          end
        end
        2'b11: begin
          state <= 2'b00;
        end
      endcase
    end
  end

  always @(state or r) begin
    case (state)
      2'b00: begin
        g <= 3'b000;
      end
      2'b01: begin
        g <= 3'b100;
      end
      2'b10: begin
        g <= 3'b010;
      end
      2'b11: begin
        g <= 3'b001;
      end
    endcase
  end

endmodule
