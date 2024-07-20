module top_module (
    input clk,
    input in,
    output logic out
);

    logic xor_out;

    xor (xor_out, in, out);

    always_ff @(posedge clk) begin
        out <= xor_out;
    end

endmodule
