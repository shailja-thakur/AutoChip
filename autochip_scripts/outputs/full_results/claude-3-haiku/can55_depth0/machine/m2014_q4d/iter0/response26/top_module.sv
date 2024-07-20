module top_module (
    input clk,
    input in,
    output logic out
);

logic prev_out;

always_ff @(posedge clk) begin
    out <= prev_out ^ in;
    prev_out <= out;
end

endmodule
