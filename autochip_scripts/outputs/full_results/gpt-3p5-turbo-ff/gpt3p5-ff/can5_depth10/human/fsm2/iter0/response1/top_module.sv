module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

  reg [1:0] state;
  reg out_reg;

  parameter OFF = 2'b00;
  parameter ON = 2'b01;

  always @(posedge clk or posedge areset) begin
    if (areset) begin
      state <= OFF;
    end else begin
      case (state)
        OFF: begin
          if (j) begin
            state <= ON;
          end else begin
            state <= OFF;
          end
        end
        ON: begin
          if (k) begin
            state <= OFF;
          end else begin
            state <= ON;
          end
        end
        default: state <= OFF;
      endcase
    end
  end

  always @(state) begin
    case (state)
      OFF: out_reg <= 0;
      ON: out_reg <= 1;
    endcase
  end

  assign out = out_reg;

endmodule
