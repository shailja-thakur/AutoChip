module top_module (
    input clk,
    input x,
    output z
);

    // D flip-flops for storing the intermediate results
    reg q1, q2, q3;
    
    // Combinational logic for the gates
    wire xor_result = x ^ q1;
    wire and_result = x & ~q2;
    wire or_result  = x | ~q3;
    
    // Sequential logic for the flip-flops
    always @(posedge clk) begin
        q1 <= xor_result;
        q2 <= and_result;
        q3 <= or_result;
    end
    
    // Three-input XNOR gate
    assign z = ~(q1 ^ q2 ^ q3);

endmodule
