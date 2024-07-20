module top_module (
  input clk,
  input resetn,
  input x,
  input y,
  output f,
  output g
);

  reg [2:0] state;
  
  assign f = (state == 3'b010) ? 1'b1 : 1'b0;
  assign g = (state == 3'b100 || state == 3'b101 || state == 3'b110) ? 1'b1 : 1'b0;
  
  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      state <= 3'b00;
    end else begin
      case (state)
        3'b00: begin
          if (x == 1'b1) begin
            state <= 3'b01;
          end else begin
            state <= 3'b00;
          end
        end
        3'b01: begin
          if (x == 1'b1) begin
            state <= 3'b01;
          end else begin
            state <= 3'b10;
          end
        end
        3'b10: begin
          if (x == 1'b1) begin
            state <= 3'b11;
          end else begin
            state <= 3'b00;
          end
        end
        3'b11: begin
          if (y == 1'b1) begin
            state <= 3'b100;
          end else begin
            state <= 3'b110;
          end
        end
        3'b100, 3'b101, 3'b110: begin
          if (y == 1'b1) begin
            state <= 3'b101;
          end else begin
            state <= 3'b011;
          end
        end
        3'b011, 3'b111: begin
          state <= 3'b001;
        end
        3'b001: begin
          state <= 3'b001;
        end
        default: begin
          state <= 3'b00;
        end
      endcase
    end
  end

endmodule
