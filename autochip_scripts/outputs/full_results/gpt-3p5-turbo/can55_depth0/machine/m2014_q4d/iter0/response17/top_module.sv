module top_module (
    input logic clk,
    input logic in,
    output logic out
);
    logic prev_out;
    
    always_ff @(posedge clk) begin
        out <= in ^ prev_out;
        prev_out <= out;
    end
endmodule
