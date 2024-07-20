module top_module (
    input [6:1] y,
    input w,
    output reg Y2,
    output reg Y4
);

    // Declare intermediate signals
    wire y2_wire;
    wire y4_wire;
    
    always @* begin
        // Logic equations for Y2 and Y4
        Y2 = (y[6:5] == 2'b00 && w == 1'b0) || (y[4] == 1'b1 && y[5] == 1'b1 && w == 1'b1);
        Y4 = (y[4] == 1'b0 && w == 1'b0) || (y[5] == 1'b1 && w == 1'b1);
    end
    
endmodule
