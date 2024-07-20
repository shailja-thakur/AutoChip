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
        // Do not change the output q when ena is low
        // q = 0; // This line is incorrect, as it will always set q to 0 when ena is low
    end
end

endmodule
