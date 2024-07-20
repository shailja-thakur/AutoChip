module top_module (
    input clk,
    input d,
    input r,
    output logic q
);

    always @(posedge clk) begin
        if (r) begin
            q <= 1'b0;
        end
        else begin
            q <= d;
        end
    end

endmodule
