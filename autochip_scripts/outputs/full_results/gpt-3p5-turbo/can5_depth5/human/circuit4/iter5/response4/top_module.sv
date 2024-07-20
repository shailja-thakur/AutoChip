module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg q
);

    // Intermediate signals
    wire w1, w2, w3;
    
    // Logic gates
    xor gate1 (w1, a, b);
    and gate2 (w2, c, d);
    and gate3 (w3, a, b);
    or gate4 (q, w1, w2, w3);
  
  always @(*) begin
    if (c && d) begin
      q = 1;
    end
    else if (a && b) begin
      q = 1;
    end
    else begin
      q = 0;
    end
  end
  
endmodule
