module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state
);

    reg c;
    reg q_reg;
    reg state_reg;

    always @(posedge clk) begin
        // Calculate c
        c <= (a & b) | (a & c) | (b & c);
        
        // Calculate q
        q_reg <= a ^ b ^ c;
        
        // Update state
        state_reg <= c;
    end

    assign q = q_reg;
    assign state = state_reg;

endmodule
