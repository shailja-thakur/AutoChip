module top_module (
    input clk,
    input in,
    output logic out
);
    initial out = 0;

    always_ff @(posedge clk) begin
        out <= in ^ out;
    end
endmodule
