module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different
);
    
    // Wire declarations
    wire [3:0] left_neighbour;
    wire [3:0] right_neighbour;
    
    // Assign left and right neighbour bits
    assign left_neighbour[0] = in[3];
    assign left_neighbour[1:3] = in[2:0];
    assign right_neighbour[0:2] = in[1:3];
    assign right_neighbour[3] = in[0];
    
    // Output assignment for out_both
    assign out_both[0] = in[0] & right_neighbour[0];
    assign out_both[1] = in[1] & right_neighbour[1];
    assign out_both[2] = in[2] & right_neighbour[2];
    
    // Output assignment for out_any
    assign out_any[1] = in[1] | right_neighbour[1];
    assign out_any[2] = in[2] | right_neighbour[2];
    assign out_any[3] = in[3] | right_neighbour[3];
    
    // Output assignment for out_different
    assign out_different[0] = in[0] != left_neighbour[0];
    assign out_different[1] = in[1] != left_neighbour[1];
    assign out_different[2] = in[2] != left_neighbour[2];
    assign out_different[3] = in[3] != left_neighbour[3];
    
endmodule
