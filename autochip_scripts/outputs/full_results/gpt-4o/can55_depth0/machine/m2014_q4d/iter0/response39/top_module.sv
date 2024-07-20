module top_module (
    input clk,
    input in,
    output logic out
);
    // Initial value of the output signal is set to 0
    initial out = 0;

    always @(posedge clk) begin
        out <= in ^ out;
    end
endmodule
