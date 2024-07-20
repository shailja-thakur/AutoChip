module top_module (
    input clk,
    input in,
    output logic out
);

    logic xor_output;
    logic d_in;
    always_comb begin
        xor_output = in ^ out;
    end

    always_ff @(posedge clk) begin
        d_in <= xor_output;
        out <= d_in;
    end

endmodule
