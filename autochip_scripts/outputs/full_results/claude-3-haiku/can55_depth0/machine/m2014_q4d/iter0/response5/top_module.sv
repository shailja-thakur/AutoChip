module top_module (
    input clk,
    input in,
    output logic out
);

    initial begin
        out = 1'b0;
    end

    always @(posedge clk) begin
        out <= in ^ out;
    end

endmodule
