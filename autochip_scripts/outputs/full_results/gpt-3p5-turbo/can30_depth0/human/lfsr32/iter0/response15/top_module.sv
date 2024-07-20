module top_module (
    input clk,
    input reset,
    output reg[31:0] q
);

reg[31:0] feedback;
    
always @(posedge clk or posedge reset) begin
    if (reset)
        q <= 32'h1;
    else begin
        feedback = q[31] ^ q[21] ^ q[1] ^ q[0];
        q <= {q[30:0], feedback};
    end
end
    
endmodule
