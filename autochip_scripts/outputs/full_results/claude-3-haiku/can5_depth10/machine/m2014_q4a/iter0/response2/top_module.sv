module top_module (
    input d,
    input ena,
    output logic q
);

always_comb begin
    if (ena) begin
        q = d;
    end else begin
        // Keep the output unchanged when enable is inactive
        // No need to assign anything here, as the output is already assigned in the previous if statement
    end
end

endmodule
