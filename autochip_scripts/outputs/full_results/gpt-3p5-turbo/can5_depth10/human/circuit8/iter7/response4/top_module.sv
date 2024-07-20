module top_module (
  input wire clock,
  input wire a,
  output reg p,
  output reg q
);

reg p_temp;
reg q_temp;

always @(posedge clock) begin
  p_temp <= p;
  q_temp <= q;
  
  if (a == 1'b1) begin
    p <= 1'b1;
    q <= 1'b1;
  end else begin
    p <= p_temp;
    q <= q_temp;
  end
end

initial begin
  $dumpfile("wave.vcd");
  $dumpvars;
  
  // Initialize inputs
  clock = 0;
  a = 0;
  
  // Apply inputs
  #25 clock = 1;
  #25 a = 1;
  #20 a = 0;
  #10 a = 1;
  #10 a = 0;
  #25 a = 0;
  #35 clock = 0;
  #5 clock = 1;
  #25 clock = 1;
  #110 clock = 0;
  
  // Stop simulation
  #10 $finish;
end

endmodule
