module top_module (
    input clk,
    input in,
    output logic out
);

    logic prev_out;

    initial begin
        out = 1'b0;
        prev_out = 1'b0;
    end

    always_ff @(posedge clk) begin
        prev_out <= out;
        out <= out ^ in;
    end

endmodule
