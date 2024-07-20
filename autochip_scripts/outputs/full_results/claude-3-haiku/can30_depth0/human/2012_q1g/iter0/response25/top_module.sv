module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    f = 0;
    
    // Check if x[3:1] is 000 or 100
    if (x[3:1] == 3'b000 || x[3:1] == 3'b100) begin
        f = 1;
    end
    
    // Check if x[3:1] is 011 or 111
    if (x[3:1] == 3'b011 || x[3:1] == 3'b111) begin
        f = 1;
    end
end

endmodule
