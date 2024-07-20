module top_module(
    input clk,
    input a, 
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Logical XOR operation on input ports a and b
    assign out_assign = a ^ b;
    
    // Combinational always block
    always @(*) begin
        out_always_comb = a ^ b;
    end
    
    // Sequential always block triggered on the rising edge of clk
    always @(posedge clk) begin
        out_always_ff = a ^ b;
    end

endmodule
