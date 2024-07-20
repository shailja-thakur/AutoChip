module top_module (
    input [6:1] y,
    input w,
    output reg Y2,
    output reg Y4
);

    // Declare intermediate signals
    reg y2_wire;
    reg y4_wire;
    
    always @* begin
        // Logic equations for Y2 and Y4
        y2_wire = (y[6] & ~w) | (y[4] & y[5] & w);
        y4_wire = (y[4] & ~w) | (y[5] & w);
    end
    
    always @(posedge clk) begin
        Y2 <= y2_wire;
        Y4 <= y4_wire;
    end
    
endmodule
