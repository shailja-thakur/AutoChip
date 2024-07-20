module top_module (
	input clk,
	input x,
	output z
);

    // Internal signals
    wire d_xor, d_and, d_or;
    wire q_xor, q_and, q_or;
    wire q_not_xor, q_not_and, q_not_or;

    // XOR gate with D flip-flop
    assign d_xor = x ^ q_xor;
    DFF dff_xor (
        .clk(clk),
        .d(d_xor),
        .q(q_xor)
    );
    
    // AND gate with D flip-flop
    assign q_not_and = ~q_and;
    assign d_and = x & q_not_and;
    DFF dff_and (
        .clk(clk),
        .d(d_and),
        .q(q_and)
    );
    
    // OR gate with D flip-flop
    assign q_not_or = ~q_or;
    assign d_or = x | q_not_or;
    DFF dff_or (
        .clk(clk),
        .d(d_or),
        .q(q_or)
    );

    // Three-input XNOR gate
    assign z = ~(q_xor ^ q_and ^ q_or);

endmodule
module DFF (
    input clk,
    input d,
    output reg q
);
    always @(posedge clk) begin
        q <= d;
    end
endmodule
