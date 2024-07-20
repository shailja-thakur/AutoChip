module top_module (
    input clk,
    input in,
    output logic out
);

always_ff @(posedge clk) begin
    out <= out ^ in;
end

endmodule
module top_module (
    input clk,
    input in,
    output logic out = 0
);

always_ff @(posedge clk) begin
    out <= out ^ in;
end

endmodule
