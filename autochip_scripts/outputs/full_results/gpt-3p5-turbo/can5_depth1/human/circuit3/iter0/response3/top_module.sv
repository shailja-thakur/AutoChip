module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

// define the internal wires
wire w1, w2;

// implement the circuit
assign w1 = a & b & c;
assign w2 = ~d;
assign q = w1 | w2;

endmodule
