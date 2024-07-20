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
  $dumpvars(0, top_module);
  
  // Test case 1
  #25 a = 0;
  #30 a = 1;
  #20 a = 0;
  
  // Test case 2
  #20 a = 1;
  #30 a = 0;
  #20 a = 1;
  
  // Test case 3
  #25 a = 0;
  #35 a = 1;
  #20 a = 0;
  
  // Test case 4
  #20 a = 1;
  #40 a = 0;
  #20 a = 1;
  
  // Test case 5
  #25 a = 0;
  #45 a = 1;
  #20 a = 0;
  
  // Test case 6
  #20 a = 1;
  #50 a = 0;
  #20 a = 1;
  
  // Test case 7
  #25 a = 0;
  #55 a = 1;
  #20 a = 0;
  
  // Test case 8
  #20 a = 1;
  #60 a = 0;
  #20 a = 1;
  
  // Test case 9
  #25 a = 0;
  #65 a = 1;
  #20 a = 0;
  
  // Test case 10
  #20 a = 1;
  #70 a = 0;
  #20 a = 1;
  
  // Test case 11
  #25 a = 0;
  #75 a = 1;
  #20 a = 0;
  
  // Test case 12
  #20 a = 1;
  #80 a = 0;
  #20 a = 1;
  
  // Test case 13
  #25 a = 0;
  #85 a = 1;
  #20 a = 0;
  
  // Test case 14
  #20 a = 1;
  #90 a = 0;
  #20 a = 1;
  
  // Test case 15
  #25 a = 0;
  #95 a = 1;
  #20 a = 0;
  
  // Test case 16
  #20 a = 1;
  #100 a = 0;
  #20 a = 1;
  
  // Test case 17
  #25 a = 0;
  #105 a = 1;
  #20 a = 0;
  
  // Test case 18
  #20 a = 1;
  #110 a = 0;
  #20 a = 1;
  
  // Test case 19
  #25 a = 0;
  #115 a = 1;
  #20 a = 0;
  
  // Test case 20
  #20 a = 1;
  #120 a = 0;
  #20 a = 1;
  
  // Test case 21
  #25 a = 0;
  #125 a = 1;
  #20 a = 0;
  
  // Test case 22
  #20 a = 1;
  #130 a = 0;
  #20 a = 1;
  
  // Test case 23
  #25 a = 0;
  #135 a = 1;
  #20 a = 0;
  
  // Test case 24
  #20 a = 1;
  #140 a = 0;
  #20 a = 1;
  
  // Test case 25
  #25 a = 0;
  #145 a = 1;
  #20 a = 0;
  
  // Test case 26
  #20 a = 1;
  #150 a = 0;
  #20 a = 1;
  
  // Test case 27
  #25 a = 0;
  #155 a = 1;
  #20 a = 0;
  
  // Test case 28
  #20 a = 1;
  #160 a = 0;
  #20 a = 1;
  
  // Test case 29
  #25 a = 0;
  #165 a = 1;
  #20 a = 0;
  
  // Test case 30
  #20 a = 1;
  #170 a = 0;
  #20 a = 1;
  
  // Test case 31
  #25 a = 0;
  #175 a = 1;
  #20 a = 0;
  
  // Test case 32
  #20 a = 1;
  #180 a = 0;
  #20 a = 1;
  
  // Test case 33
  #25 a = 0;
  #185 a = 1;
  #20 a = 0;
  
  // Test case 34
  #20 a = 1;
  #190 a = 0;
  
  #20 $finish;
end 

endmodule
