module top_module (
    input clk,
    input in,
    output logic out
);

logic temp_out;

always_ff @(posedge clk) begin
    temp_out <= out ^ in;
    out <= temp_out;
end

endmodule
