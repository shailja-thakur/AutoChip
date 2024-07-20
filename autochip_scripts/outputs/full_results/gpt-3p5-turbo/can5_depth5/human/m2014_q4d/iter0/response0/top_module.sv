module top_module (
    input clk,
    input in,
    output logic out
);

    logic xor_out;
    logic d_ff_out;
    
    xor u1 (
        .a(in),
        .b(out),
        .out(xor_out)
    );
    
    always @(posedge clk) begin
        d_ff_out <= xor_out;
        out <= d_ff_out;
    end

endmodule
module xor (
    input a,
    input b,
    output logic out
);

    assign out = a ^ b;

endmodule
