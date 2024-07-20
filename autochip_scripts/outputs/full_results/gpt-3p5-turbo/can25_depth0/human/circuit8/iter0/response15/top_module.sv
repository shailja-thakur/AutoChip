module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

  reg p_temp;
  reg q_temp;
  
  always @(posedge clock) begin
    if (a == 1 && p == 0 && q == 0) begin
      p_temp <= 1;
      q_temp <= 0;
    end else if (a == 1 && p == 1 && q == 0) begin
      p_temp <= 1;
      q_temp <= 0;
    end else if (a == 1 && p == 0 && q == 1) begin
      p_temp <= 1;
      q_temp <= 0;
    end else if (a == 1 && p == 1 && q == 1) begin
      p_temp <= 0;
      q_temp <= 1;
    end else if (a == 0 && p == 1 && q == 1) begin
      p_temp <= 0;
      q_temp <= 0;
    end else if (a == 0 && p == 0 && q == 0) begin
      p_temp <= 0;
      q_temp <= 0;
    end else if (a == 0 && p == 1 && q == 0) begin
      p_temp <= 1;
      q_temp <= 1;
    end else begin
      p_temp <= p;
      q_temp <= q;
    end
  end

  assign p = p_temp;
  assign q = q_temp;

endmodule
