module top_module (
  input wire clock,
  input wire a,
  output reg p,
  output reg q
);

  reg p_next;
  reg q_next;
  
  always @(posedge clock) begin
    case({a, p})
      2'b00: begin
        p_next <= p;
        q_next <= q;
      end
      2'b01: begin
        p_next <= p;
        q_next <= ~q;
      end
      2'b10: begin
        p_next <= ~p;
        q_next <= q;
      end
      2'b11: begin
        p_next <= ~p;
        q_next <= ~q;
      end
    endcase
  end

  always @(posedge clock) begin
    if (a) begin
      p <= p_next;
      q <= q_next;
    end
  end

endmodule
