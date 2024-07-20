module top_module (
    input d,
    input ena,
    output logic q
);

    // Internal storage for output
    logic internal_q;

    // Always block to control the flow of data
    always @(*) begin
        if (ena) begin
            internal_q = d;
        end
    end

    // Assign the internal signal to output
    assign q = internal_q;

endmodule
