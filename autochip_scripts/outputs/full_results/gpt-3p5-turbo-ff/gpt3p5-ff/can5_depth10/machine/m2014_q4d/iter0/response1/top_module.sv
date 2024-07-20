module top_module (
    input clk,
    input in,
    output logic out
);
    logic prev_out;
    always_ff @(posedge clk)
        out <= in ^ prev_out;
        prev_out <= out;
endmodule
