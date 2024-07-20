module top_module (
    input d,
    input ena,
    output logic q
);
    
    always @(ena, d) begin
        if (ena) begin
            q <= d;
        end
    end

endmodule
