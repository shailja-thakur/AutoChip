module top_module (
    input clk,
    input in,
    output logic out
);

    initial begin
        out = 0;
    end

    always_ff @(posedge clk) begin
        out <= in ^ out;
    end

endmodule
