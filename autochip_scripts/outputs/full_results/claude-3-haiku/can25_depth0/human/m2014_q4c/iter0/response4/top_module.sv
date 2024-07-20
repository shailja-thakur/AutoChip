module top_module (
    input clk,
    input d,
    input r,
    output logic q
);

    always @(posedge clk) begin
        if (r)
            q <= 1'b0;
        else
            q <= d;
    end

endmodule
