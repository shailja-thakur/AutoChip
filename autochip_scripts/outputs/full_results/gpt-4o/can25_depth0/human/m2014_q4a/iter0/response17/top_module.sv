module top_module (
    input d,
    input ena,
    output logic q
);

    always @(*) begin
        if (ena) begin
            q = d;
        end
        // If ena is not asserted, q retains its value (no need to assign anything here)
    end

endmodule
