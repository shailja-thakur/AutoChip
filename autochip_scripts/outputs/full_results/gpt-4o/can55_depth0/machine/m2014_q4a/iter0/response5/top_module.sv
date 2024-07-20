module top_module (
    input d,
    input ena,
    output logic q
);

    always @* begin
        if (ena) begin
            q = d;
        end else begin
            q = q; // No change if enable is low
        end
    end

endmodule
