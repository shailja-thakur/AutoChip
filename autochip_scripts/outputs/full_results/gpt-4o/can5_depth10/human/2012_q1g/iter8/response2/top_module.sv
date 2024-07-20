module top_module (
    input [4:1] x,
    output logic f
);

always @(*) begin
    f = ( ( ~x[3] & ~x[4] & ~x[2] & ~x[1]) | // 0000
          ( ~x[3] & ~x[4] &  x[2] &  x[1]) | // 0010
          ( ~x[3] &  x[4] &  x[2] & ~x[1]) | // 0110
          ( x[3] &  x[4] & ~x[2] & ~x[1]) | // 1000
          ( x[3] &  x[4] & ~x[2] &  x[1]) | // 1001
          ( x[3] &  x[4] &  x[2] & ~x[1]) | // 1010
          ( x[3] &  x[4] &  x[2] &  x[1]) // 1110
        );   
end

endmodule
