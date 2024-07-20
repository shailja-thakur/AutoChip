module top_module (
    input logic clk,
    input logic d,
    input logic r,
    output logic q
);
    always_ff @(posedge clk) begin
        if (r) begin
            q <= 0;
        end else begin
            q <= d;
        end
    end
endmodule
