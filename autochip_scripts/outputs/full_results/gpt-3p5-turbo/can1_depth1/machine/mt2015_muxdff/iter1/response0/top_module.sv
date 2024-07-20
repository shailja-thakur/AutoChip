module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q);

    always @(posedge clk) begin
        if (L == 1'b1)
            Q <= r_in;
        else
            Q <= q_in;
    end
    
    // Initialize Q to 0 at time 0
    initial begin
        Q = 1'b0;
    end

endmodule
