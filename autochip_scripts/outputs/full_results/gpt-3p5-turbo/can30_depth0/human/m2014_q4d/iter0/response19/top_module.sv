module top_module (
    input clk,
    input in,
    output logic out
);

    logic xor_out;
    logic d;
    
    xor2 xor_gate(.A(in), .B(out), .Z(xor_out));
    d_ff d_flip_flop(.clk(clk), .d(xor_out), .q(out));
    
endmodule
module xor2(
    input logic A,
    input logic B, 
    output logic Z
);
    assign Z = A ^ B;
endmodule
module d_ff(
    input logic clk,
    input logic d,
    output logic q
);
    always_ff @(posedge clk)
        q <= d;
endmodule
