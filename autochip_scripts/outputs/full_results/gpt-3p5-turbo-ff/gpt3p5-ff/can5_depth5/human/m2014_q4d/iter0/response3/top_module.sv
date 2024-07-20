module top_module (
    input clk,
    input in,
    output logic out
);

    logic xor_input;
    logic dff_input;

    xor_gate xor1(.a(in), .b(out), .out(xor_input));

    always @(posedge clk) begin
        dff_input = xor_input;
    end

    always @(posedge clk) begin
        out <= dff_input;
    end

endmodule
module xor_gate (
    input a,
    input b,
    output logic out
);
    assign out = a ^ b;
endmodule
