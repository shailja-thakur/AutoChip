module top_module (
    input clk,
    input in,
    output logic out
);
// D flip flop module
module dff (
    input clk,
    input d,
    output reg q
);

    always @ (posedge clk) begin
        q <= d;
    end

endmodule
module xor_gate (
    input a,
    input b,
    output reg y
);

    assign y = a ^ b;

endmodule
