module top_module (
  input wire clock,
  input wire a,
  output reg p,
  output reg q
);

reg p_temp;
reg q_temp;

always @(posedge clock) begin
  p_temp <= p; // store previous value of p
  q_temp <= q; // store previous value of q
  
  if (a == 1'b1) begin
    p <= 1'b1; // set p to 1
    q <= 1'b0; // set q to 0
  end else begin
    p <= p_temp; // restore previous value of p
    q <= q_temp; // restore previous value of q
  end
end

endmodule
