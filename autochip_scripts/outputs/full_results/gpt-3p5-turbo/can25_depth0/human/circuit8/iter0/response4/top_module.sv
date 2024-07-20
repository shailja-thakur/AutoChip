module top_module (
  input clock,
  input a, 
  output reg p,
  output reg q
);

reg p_temp;
reg q_temp;

always @(posedge clock) begin
  p_temp <= p;
  q_temp <= q;
  
  case({p_temp, q_temp, a})
    3'b000: begin
      p <= 0;
      q <= 0;
    end
    3'b001: begin
      p <= 1;
      q <= 0;
    end
    3'b010: begin
      p <= 1;
      q <= 1;
    end
    3'b011: begin
      p <= 1;
      q <= 0;
    end
    3'b100: begin
      p <= 1;
      q <= 1;
    end
    3'b101: begin
      p <= 0;
      q <= 1;
    end
    default: begin
      p <= 0;
      q <= 0;
    end
  endcase
end

endmodule
