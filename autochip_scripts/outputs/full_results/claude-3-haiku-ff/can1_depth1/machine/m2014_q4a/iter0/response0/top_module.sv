module top_module (
    input d,
    input ena,
    output logic q
);

always_comb begin
    if (ena) begin
        q = d;
    end
    else begin
        // The output 'q' should remain unchanged when 'ena' is low
        // No assignment is needed here, as the output 'q' is declared as 'logic'
        // which means it will maintain its previous value when not explicitly assigned.
    end
end

endmodule
