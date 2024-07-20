module top_module(
    input clk,
    input a, 
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

    // Assign the result of XOR operation to out_assign
    assign out_assign = a ^ b;

    // Always block for combinational logic
    always @(*) begin
        out_always_comb = out_assign;
    end

    // Always block for sequential logic (triggered on rising edge of clk)
    always @(posedge clk) begin
        out_always_ff = out_assign;
    end
    
endmodule
