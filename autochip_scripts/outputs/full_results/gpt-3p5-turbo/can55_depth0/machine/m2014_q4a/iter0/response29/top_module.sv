module top_module (
    input wire d,
    input wire ena,
    output logic q
);
    
    always_comb begin
        if (ena) begin
            q = d;
        end
    end
    
endmodule
