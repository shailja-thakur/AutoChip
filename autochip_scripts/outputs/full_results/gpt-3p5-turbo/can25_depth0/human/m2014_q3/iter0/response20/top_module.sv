module top_module (
    input [4:1] x,
    output logic f
);

// Creating the truth table for the given function
table_entry truth_table[16] = {
    0, 1, 2, 1,   // x = 0000, f = d
    1, 2, 3, 0,   // x = 0001, f = 0
    3, 3, 2, 2,   // x = 0011, f = d
    3, 3, 2, 2    // x = 0010, f = d
};

integer i;

always_comb begin
    for(i=0; i<16; i=i+1) begin
        if(x == i) begin
            f = truth_table[i];
            break;
        end
    end
end

endmodule
