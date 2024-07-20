module top_module (
    input clk,
    input in,
    output logic out
);

    // Internal signal to hold the previous value of out
    logic previous_out;

    // Sequential logic for the toggle flip-flop
    always_ff @(posedge clk)
    begin
        previous_out <= out;
        out <= in ^ previous_out;
    end

endmodule
