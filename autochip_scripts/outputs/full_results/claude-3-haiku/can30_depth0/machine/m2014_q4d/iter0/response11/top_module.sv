module top_module (
    input clk,
    input in,
    output logic out
);

    logic prev_out;

    always_ff @(posedge clk) begin
        prev_out <= out;
        out <= out ^ in;
    end

    initial begin
        out <= 1'b0;
    end

endmodule
