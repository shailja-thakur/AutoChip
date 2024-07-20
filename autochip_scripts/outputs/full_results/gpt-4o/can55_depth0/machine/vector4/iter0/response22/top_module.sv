module top_module (
    input [7:0] in,
    output [31:0] out
);
    assign out = {3{in}, in};  // Replicate the 8-bit input "in" 3 times to form the first 24 bits, then append "in" to form the last 8 bits
endmodule
