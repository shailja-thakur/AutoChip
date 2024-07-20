module top_module (
    input clk,
    input in,
    output logic out
);

    // intermediate signal to hold previous value of output signal
    logic out_prev;

    always_ff @(posedge clk)
    begin
        out_prev <= out;
        out <= in ^ out_prev;
    end

endmodule
