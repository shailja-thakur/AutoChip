module top_module (
    input clk,
    input in,
    output logic out
);

    logic temp_out;

    always_ff @(posedge clk) begin
        temp_out <= out ^ in;
    end

    assign out = temp_out;

endmodule
