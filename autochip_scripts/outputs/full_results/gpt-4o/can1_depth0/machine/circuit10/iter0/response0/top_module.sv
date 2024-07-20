module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state
);

    reg c;
    wire c_next;

    // Calculate next value of c
    assign c_next = (a & b) | (a & c) | (b & c);
    
    // Register to store the value of c
    always @(posedge clk) begin
        c <= c_next;
    end

    // Calculate outputs
    assign q = a ^ b ^ c;
    assign state = c;
    
endmodule
