module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

  reg p_next;
  reg q_next;

  always @(posedge clock) begin
    case({a, p, q})
      // First case
      3'b000: begin
        p_next = 1'b0;
        q_next = 1'b0;
      end

      // Second case
      3'b001: begin
        p_next = p;
        q_next = p;
      end

      // Third case
      3'b010: begin
        p_next = 1'b0;
        q_next = 1'b0;
      end

      // Fourth case
      3'b011: begin
        p_next = p;
        q_next = p;
      end

      // Fifth case
      3'b100: begin
        p_next = 1'b1;
        q_next = 1'b0;
      end

      // Sixth case
      3'b101: begin
        p_next = a;
        q_next = p_next;
      end

      // Seventh case
      3'b110: begin
        p_next = 1'b0;
        q_next = 1'b0;
      end

      // Eighth case
      3'b111: begin
        p_next = 1'b0;
        q_next = 1'b1;
      end
    endcase
  end

  always @(posedge clock) begin
    p <= p_next;
    q <= q_next;
  end

endmodule
