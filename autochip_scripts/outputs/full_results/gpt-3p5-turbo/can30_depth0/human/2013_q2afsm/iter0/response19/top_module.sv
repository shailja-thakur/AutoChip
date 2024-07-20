module fsm (
  input clk,
  input resetn,
  input [2:0] r,
  output [2:0] g
);

  reg [1:0] state;

  always @(posedge clk or negedge resetn) begin
    if (!resetn)
      state <= 2'b00; // Reset state
    else begin
      case(state)
        2'b00: begin
          if (r[0] == 1'b1)
            state <= 2'b01;
          else if (r[1] == 1'b1)
            state <= 2'b10;
          else if (r[2] == 1'b1)
            state <= 2'b11;
          else
            state <= 2'b00;
        end
        2'b01: begin
          if (r[0] == 1'b0)
            state <= 2'b00;
          else
            state <= 2'b01;
        end
        2'b10: begin
          if (r[1] == 1'b0)
            state <= 2'b00;
          else
            state <= 2'b10;
        end
        2'b11: begin
          if (r[2] == 1'b0)
            state <= 2'b00;
          else
            state <= 2'b11;
        end
        default: state <= 2'b00;
      endcase
    end
  end

  always @(state) begin
    case(state)
      2'b01: g[0] = 1'b1;
      2'b10: g[1] = 1'b1;
      2'b11: g[2] = 1'b1;
      default: begin
        g[0] = 1'b0;
        g[1] = 1'b0;
        g[2] = 1'b0;
      end
    endcase
  end

endmodule
module top_module (
  input clk,
  input resetn,
  input [3:1] r,
  output [3:1] g
);
  fsm fsm_inst (
    .clk(clk),
    .resetn(resetn),
    .r(r),
    .g(g)
  );
endmodule
