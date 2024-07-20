module top_module (
    input clk,
    input in,
    output logic out
);

    logic previous_out;

    always_ff @(posedge clk)
    begin
        out <= in ^ previous_out;
        previous_out <= out;
    end

endmodule
