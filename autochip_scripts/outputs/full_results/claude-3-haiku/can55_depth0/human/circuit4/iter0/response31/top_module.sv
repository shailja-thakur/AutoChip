module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

wire w1, w2, w3, w4;

// Implement the logic based on the provided simulation waveforms
assign w1 = ~d;
assign w2 = c & w1;
assign w3 = b ^ c;
assign w4 = a | w3;
assign q = w2 | w4;

endmodule
