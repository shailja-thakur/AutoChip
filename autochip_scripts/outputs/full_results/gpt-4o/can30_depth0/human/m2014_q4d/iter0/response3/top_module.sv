module top_module (
    input clk,
    input in,
    output logic out
);

    logic d;

    always @(posedge clk) begin
        out <= d;
    end

    assign d = in ^ out;

endmodule
