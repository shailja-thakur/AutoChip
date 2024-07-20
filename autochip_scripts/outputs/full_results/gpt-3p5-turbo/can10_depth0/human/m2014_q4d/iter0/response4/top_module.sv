module top_module (
    input clk,
    input in,
    output logic out
);

    reg out_ff;
    wire xor_input;
    
    xor_gate my_xor(
        .a(in),
        .b(out_ff),
        .y(xor_input)
    );

    always@(posedge clk) begin
        out_ff <= xor_input;
        out <= out_ff;
    end

endmodule
module xor_gate(
	input a,
	input b,
	output y
);

    assign y = a ^ b;

endmodule
