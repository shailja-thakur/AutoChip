module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    // Logic for q
    always @* begin
        if ((~a & ~b & ~c & d) | (~a & ~b & c & d) | (~a & b & ~c & d) | (~a & b & c & ~d) | (a & ~b & ~c & ~d) | (a & ~b & c & ~d) | (a & b & ~c & ~d) | (a & b & c & d)) begin
            q = 1;
        end else begin
            q = 0;
        end
    end
  
endmodule
