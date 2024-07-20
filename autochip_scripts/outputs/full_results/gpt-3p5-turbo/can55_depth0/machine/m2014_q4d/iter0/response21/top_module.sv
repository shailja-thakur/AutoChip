module top_module (
    input clk,
    input in,
    output logic out
);

    logic previous_out;

    always_ff @(posedge clk)
        previous_out <= out;

    assign out = in ^ previous_out;

endmodule
