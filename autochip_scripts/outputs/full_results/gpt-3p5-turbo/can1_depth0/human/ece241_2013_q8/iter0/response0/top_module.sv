module top_module (
  input clk,
  input aresetn,
  input x,
  output reg z
);

  reg [1:0] state;
  reg [2:0] shift_reg;
  wire x_seq;

  assign x_seq = (shift_reg[2] & shift_reg[1] & ~shift_reg[0]);

  always @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
      state <= 2'b00;
      shift_reg <= 3'b000;
      z <= 1'b0;
    end else begin
      case (state)
        2'b00: begin
          if (x == 1'b1)
            state <= 2'b01;
          else
            state <= 2'b00;
          shift_reg <= {shift_reg[1:0], x};
        end
        2'b01: begin
          if (x == 1'b0)
            state <= 2'b10;
          else
            state <= 2'b00;
          shift_reg <= {shift_reg[1:0], x};
        end
        2'b10: begin
          if (x_seq)
            state <= 2'b11;
          else
            state <= 2'b00;
          shift_reg <= {shift_reg[1:0], x};
        end
        2'b11: begin
          if (x_seq)
            state <= 2'b11;
          else
            state <= 2'b00;
          shift_reg <= {shift_reg[1:0], x};
        end
      endcase
    end
  end

  always @(x_seq) begin
    if (state == 2'b11)
      z <= 1'b1;
    else
      z <= 1'b0;
  end

endmodule
