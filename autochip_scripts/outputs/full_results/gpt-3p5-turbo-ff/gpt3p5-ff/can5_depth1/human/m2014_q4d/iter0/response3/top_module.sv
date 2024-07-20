module top_module (
    input clk,
    input in,
    output logic out
);
    
    logic xor_output;
    logic d;

    xor_gate xor1 (.a(in), .b(out), .y(xor_output));
    d_ff dff (.d(xor_output), .clk(clk), .q(out));
    
endmodule
module xor_gate (
    input logic a,
    input logic b,
    output logic y
);
    assign y = a ^ b;
endmodule
module d_ff (
    input logic d,
    input clk,
    output logic q
);
    always @(posedge clk)
        q <= d;
endmodule
