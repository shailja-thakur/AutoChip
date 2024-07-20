module top_module (
    input wire clk,
    input wire d,
    input wire ar,
    output wire q
);
    reg q;
    
    always @(posedge clk or posedge ar) begin
        if (ar)
            q <= 0;
        else
            q <= d;
    end
    
    assign q = q;
    
endmodule
