module top_module (
    input clk,
    input x,
    output z
);
    // Flip-flop outputs
    reg [2:0] d_reg;
    
    // Flip-flop inputs
    wire d_out0;
    wire d_out1;
    wire d_out2;
    
    // Logic gates
    xor_gate gate1 (.a(d_out0), .b(d_reg[0]), .y(d_out0));
    and_gate gate2 (.a(~d_out1), .b(d_reg[1]), .y(d_out1));
    or_gate gate3 (.a(~d_out2), .b(d_reg[2]), .y(d_out2));
    
    // Flip-flops
    always @(posedge clk) begin
        d_reg <= {d_out2, d_out1, x};
    end
    
    // XNOR gate
    xnor_gate gate4 (.a(d_out2), .b(d_out1), .c(d_out0), .y(z));
endmodule
module xor_gate (
    input a,
    input b,
    output y
);
    assign y = a ^ b;
endmodule
module and_gate (
    input a,
    input b,
    output y
);
    assign y = a & b;
endmodule
module or_gate (
    input a,
    input b,
    output y
);
    assign y = a | b;
endmodule
module xnor_gate (
    input a,
    input b,
    input c,
    output y
);
    assign y = ~(a ^ b ^ c);
endmodule
