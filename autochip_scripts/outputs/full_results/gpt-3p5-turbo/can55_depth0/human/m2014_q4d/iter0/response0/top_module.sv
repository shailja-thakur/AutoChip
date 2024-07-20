module top_module (
    input clk,
    input in,
    output logic out
);
    logic xor_out;
    logic flip_flop_out;
    
    xor_gate xor1(.in1(in), .in2(out), .out(xor_out));
    flip_flop ff1(.clk(clk), .d(xor_out), .q(flip_flop_out));
    
    assign out = flip_flop_out;
    
    xor_gate xor1(.in1(in), .in2(out), .out(xor_out));
    
    always @(posedge clk)
        flip_flop_out <= xor_out;
endmodule
module xor_gate (
    input logic in1,
    input logic in2,
    output logic out
);
    assign out = in1 ^ in2;
endmodule
module flip_flop (
    input clk,
    input logic d,
    output logic q
);
    always @(posedge clk)
        q <= d;
endmodule
