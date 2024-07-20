module top_module (
    input clk,
    input in,
    output logic out
);

    initial begin
        out = 1'b0;
    end

    always_ff @(posedge clk) begin
        out <= out ^ in;
    end

endmodule
