module top_module(
    input clk,
    input a,
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Assign the result of the XOR operation between a and b to out_assign
    assign out_assign = a ^ b;
    
    // Use an always_comb block to assign the value of out_assign to out_always_comb
    always_comb begin
        out_always_comb = out_assign;
    end
    
    // Use an always_ff block triggered by the rising edge of clk to assign the value of out_assign to out_always_ff
    always_ff @(posedge clk) begin
        out_always_ff <= out_assign;
    end

endmodule
