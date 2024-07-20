module top_module(
    input clk,
    input load,
    input [511:0] data,
    output reg [511:0] q);

    wire [511:0] intermediate;
    
    assign intermediate = ~((q[511:1] & q[510:0] & {q[510:0], 1'b0}) | 
                            (~q[511:1] & ~q[511:0] & ~{q[510:0], 1'b0}) | 
                            (q[511:1] & ~q[511:0] & ~{q[510:0], 1'b0}));
                            
    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= intermediate;
    end
endmodule
