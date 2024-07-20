module top_module (
    input clk,
    input in,
    output logic out
);

    logic d;
    logic q;

    xor2 #(2) xor_gate (
        .a(in),
        .b(out),
        .z(d)
    );

    always_ff @(posedge clk) begin
        q <= d;
    end

    assign out = q;

endmodule
