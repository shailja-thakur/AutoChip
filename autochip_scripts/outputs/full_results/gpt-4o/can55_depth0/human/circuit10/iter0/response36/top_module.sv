module top_module (
    input clk,
    input a,
    input b,
    output reg state,
    output reg q
);

    always @(posedge clk) begin
        // Using the value of 'a' and 'b' to determine next state
        state <= (a & b) | (~a & ~b);
        q <= state;
    end
    
endmodule
