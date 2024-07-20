module top_module(
    input clk,
    input a, 
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);
    
    // Perform the logical XOR operation and assign to out_assign
    assign out_assign = a ^ b;
    
    // Use always_comb to assign the same value as out_assign
    always @* begin
        out_always_comb = a ^ b;
    end
    
    // Use always_ff to assign the same value as out_assign on the rising edge of the clock
    always @(posedge clk) begin
        out_always_ff = a ^ b;
    end

endmodule
