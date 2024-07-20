module top_module (
    input [6:1] y,
    input w,
    output [1:0] Y2,
    output [1:0] Y4
);

    // Declare intermediate signals
    wire [1:0] y2_wire;
    wire [1:0] y4_wire;
    
    assign Y2 = y2_wire;
    assign Y4 = y4_wire;
    
    // Logic equations for Y2 and Y4
    assign y2_wire = (y[6:5] == 2'b00 && w == 1'b0) ? 2'b01 : (y[4] == 1'b1 && y[5] == 1'b1 && w == 1'b1) ? 2'b10 : 2'b00;
    assign y4_wire = (y[4] == 1'b1 && w == 1'b0) ? 2'b10 : (y[5] == 1'b1 && w == 1'b1) ? 2'b10 : 2'b00;
    
endmodule
