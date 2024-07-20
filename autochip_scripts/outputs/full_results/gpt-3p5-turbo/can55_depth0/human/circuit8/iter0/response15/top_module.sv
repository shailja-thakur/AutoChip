module top_module (
  input clock,
  input a,
  output reg p,
  output reg q
);

reg p_next;
reg q_next;

always @(posedge clock) begin
  case ({p, q, a})
    3'b000: begin
      p_next = 1'b0;
      q_next = 1'b0;
    end
    3'b001: begin
      p_next = 1'b0;
      q_next = 1'b0;
    end
    3'b010: begin
      p_next = 1'b0;
      q_next = 1'b0;
    end
    3'b011: begin
      p_next = 1'b0;
      q_next = 1'b0;
    end
    3'b100: begin
      p_next = 1'b0;
      q_next = 1'b0;
    end
    3'b101: begin
      p_next = 1'b0;
      q_next = 1'b0;
    end
    3'b110: begin
      p_next = 1'b0;
      q_next = 1'b0;
    end
    3'b111: begin
      p_next = 1'b0;
      q_next = 1'b0;
    end
    3'b000: begin
      p_next = 1'b0;
      q_next = 1'b0;
    end
    3'b001: begin
      p_next = 1'b0;
      q_next = 1'b0;
    end
    3'b010: begin
      p_next = 1'b0;
      q_next = 1'b0;
    end
    3'b011: begin
      p_next = 1'b0;
      q_next = 1'b0;
    end
    3'b100: begin
      p_next = 1'b0;
      q_next = 1'b0;
    end
    3'b101: begin
      p_next = 1'b1;
      q_next = 1'b0;
    end
    3'b110: begin
      p_next = 1'b1;
      q_next = 1'b1;
    end
    3'b111: begin
      p_next = 1'b0;
      q_next = 1'b0;
    end
    3'b000: begin
      p_next = 1'b1;
      q_next = 1'b1;
    end
    3'b001: begin
      p_next = 1'b0;
      q_next = 1'b0;
    end
    3'b010: begin
      p_next = 1'b1;
      q_next = 1'b1;
    end
    3'b011: begin
      p_next = 1'b0;
      q_next = 1'b0;
    end
    3'b100: begin
      p_next = 1'b1;
      q_next = 1'b1;
    end
    3'b101: begin
      p_next = 1'b0;
      q_next = 1'b0;
    end
    3'b110: begin
      p_next = 1'b1;
      q_next = 1'b1;
    end
    3'b111: begin
      p_next = 1'b0;
      q_next = 1'b0;
    end
    3'b000: begin
      p_next = 1'b0;
      q_next = 1'b1;
    end
    3'b001: begin
      p_next = 1'b0;
      q_next = 1'b1;
    end
    3'b010: begin
      p_next = 1'b0;
      q_next = 1'b1;
    end
    3'b011: begin
      p_next = 1'b0;
      q_next = 1'b1;
    end
    3'b100: begin
      p_next = 1'b0;
      q_next = 1'b1;
    end
    3'b101: begin
      p_next = 1'b0;
      q_next = 1'b1;
    end
    3'b110: begin
      p_next = 1'b0;
      q_next = 1'b1;
    end
    3'b111: begin
      p_next = 1'b1;
      q_next = 1'b1;
    end
    default: begin
      p_next = 1'b0;
      q_next = 1'b0;
    end
  endcase
end

always @(posedge clock) begin
  if (p_next !== p) begin
    p <= p_next;
  end
  if (q_next !== q) begin
    q <= q_next;
  end
end

endmodule
