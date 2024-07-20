module top_module (
    input clk,
    input in,
    output logic out
);
    logic prev_out;
    always_ff @(posedge clk)
    begin
        prev_out <= out;
        out <= in ^ prev_out;
    end
    initial begin
        out = 0;
    end
endmodule
