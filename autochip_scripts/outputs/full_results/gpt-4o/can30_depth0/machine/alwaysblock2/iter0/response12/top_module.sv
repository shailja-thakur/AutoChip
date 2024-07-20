module top_module(
    input clk,
    input a, 
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Perform logical XOR and assign the result to out_assign
    assign out_assign = a ^ b;

    // Use always block to assign the same value to out_always_comb
    always @(*) begin
        out_always_comb = a ^ b;
    end

    // Use always block triggered on the rising edge of clk to assign the same value to out_always_ff
    always @(posedge clk) begin
        out_always_ff = a ^ b;
    end
    
endmodule
