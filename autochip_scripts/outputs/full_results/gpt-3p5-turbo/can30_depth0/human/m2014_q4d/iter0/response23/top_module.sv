module top_module (
	input clk,
	input in,
	output logic out
);

    logic xor_output;
    logic flop_output;

    xor_gate U1 (
        .a(in),
        .b(out),
        .y(xor_output)
    );

    d_flip_flop U2 (
        .clk(clk),
        .d(xor_output),
        .q(flop_output)
    );

    assign out = flop_output;

    // XOR gate implementation
    // Assuming xor_gate module is defined and implemented separately

    module xor_gate (
        input a,
        input b,
        output logic y
    );
        assign y = a ^ b;
    endmodule
module d_flip_flop (
        input clk,
        input d,
        output logic q
    );
        logic internal_q;
        
        always @(posedge clk) begin
            internal_q <= d;
        end
        
        assign q = internal_q;
    endmodule
