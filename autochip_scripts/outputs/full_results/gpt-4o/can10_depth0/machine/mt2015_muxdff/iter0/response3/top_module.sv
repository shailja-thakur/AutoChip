module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q);
    
    // Initialize Q to 0
    initial begin
        Q = 0;
    end
    
    always @(posedge clk) begin
        if (L)
            Q <= r_in; // If select signal L is high, output Q is set to r_in
        else
            Q <= q_in; // If select signal L is low, output Q is set to q_in
    end
endmodule
