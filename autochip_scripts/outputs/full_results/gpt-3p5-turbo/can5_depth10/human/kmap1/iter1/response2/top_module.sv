module top_module(
    input a, 
    input b,
    input c,
    output out
);
    
    // K-map cell inputs
    wire cell_00;
    wire cell_01;
    wire cell_11;
    wire cell_10;
    
    // K-map cell outputs
    wire cell_00_out;
    wire cell_01_out;
    wire cell_11_out;
    wire cell_10_out;
    
    // K-map outputs
    wire row_0_out;
    wire row_1_out;
    wire col_0_out;
    wire col_1_out;
    
    // K-map cell implementations
    assign cell_00_out = ~(a & ~b & ~c);
    assign cell_01_out = ~(a & b & ~c);
    assign cell_11_out = 1;
    assign cell_10_out = 1;
    
    // K-map row and column implementations
    assign row_0_out = cell_00_out | cell_01_out;
    assign row_1_out = cell_11_out | cell_10_out;
    assign col_0_out = cell_00_out | cell_10_out;
    assign col_1_out = cell_01_out | cell_11_out;
    
    // Final output
    assign out = row_0_out & row_1_out & col_0_out & col_1_out;
    
endmodule
