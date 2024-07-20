module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    // Use always_comb instead of always @(*)
    always_comb begin
        // Add missing sensitivity list elements
        q = a & b & c | d;
    end
endmodule
