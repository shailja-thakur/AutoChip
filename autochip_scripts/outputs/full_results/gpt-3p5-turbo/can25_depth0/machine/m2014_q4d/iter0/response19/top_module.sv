module top_module (
    input clk,
    input in,
    output logic out
);

    logic previous_out; // a signal to store the previous output value

    always_ff @(posedge clk) begin
        previous_out <= out;
        out <= in ^ previous_out;
    end

endmodule
