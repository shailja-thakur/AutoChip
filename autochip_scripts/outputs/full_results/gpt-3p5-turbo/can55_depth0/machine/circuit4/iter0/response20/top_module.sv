module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output reg q
);

  // Perform OR operation between inputs b and c
  always @(*)
    begin
        q = b || c;
    end

endmodule
