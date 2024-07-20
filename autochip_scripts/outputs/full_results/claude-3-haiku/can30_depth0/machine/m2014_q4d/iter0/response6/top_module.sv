module top_module (
    input clk,
    input in,
    output logic out
);

    always @(posedge clk) begin
        out <= out ^ in;
    end

endmodule
