module top_module (
    input clk,
    input in,
    output logic out
);

logic previous_out;

initial begin
    out = 0;
    previous_out = 0;
end

always_ff @(posedge clk) begin
    previous_out = out;
    out = previous_out ^ in;
end

endmodule
