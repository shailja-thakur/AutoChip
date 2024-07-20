module top_module (
    input clk,
    input in,
    output logic out
);

    logic out_new;

    always_ff @(posedge clk) begin
        out_new <= in ^ out;
    end

    always_comb begin
        out <= out_new;
    end

endmodule
