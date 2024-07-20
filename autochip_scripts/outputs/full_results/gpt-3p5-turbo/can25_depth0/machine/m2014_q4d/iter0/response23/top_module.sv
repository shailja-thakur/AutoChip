module top_module (
    input wire clk,
    input wire in,
    output logic out
);
    reg r;

    always_ff @(posedge clk) begin
        out <= r ^ in;
        r <= in;
    end
endmodule
