module top_module (
    input clk,
    input in,
    output logic out
);
    logic xor_out;

    always_ff @(posedge clk) begin
        xor_out = in ^ out;
        out <= xor_out;
    end
endmodule
