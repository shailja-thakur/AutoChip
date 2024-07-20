module top_module (
    input clk,
    input in,
    output logic out
);

reg temp_out;

always_ff @(posedge clk) begin
    temp_out <= temp_out ^ in;
end

assign out = temp_out;

endmodule
