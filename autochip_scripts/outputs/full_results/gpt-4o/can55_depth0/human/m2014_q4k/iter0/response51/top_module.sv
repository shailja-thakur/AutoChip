module top_module (
    input clk,
    input resetn,
    input in,
    output out
);
    
    reg [3:0] q;
    
    always @(posedge clk) begin
        if (!resetn)
            q <= 4'b0000;
        else
            q <= {q[2:0], in};
    end
    
    assign out = q[3];

endmodule
