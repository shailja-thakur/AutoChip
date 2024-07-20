module top_module (
    input clk,
    input in,
    output logic out
);
    // Initial value of out
    initial
        out = 0;

    // Always block triggered on the positive edge of the clock
    always_ff @(posedge clk) begin
        out <= out ^ in;
    end
endmodule
