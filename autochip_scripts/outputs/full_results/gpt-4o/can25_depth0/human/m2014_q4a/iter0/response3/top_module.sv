module top_module (
    input d,
    input ena,
    output logic q
);
    always @(*) begin
        if (ena) begin
            q = d;
        end
        // No else clause needed because q retains its value when ena is low
    end
endmodule
