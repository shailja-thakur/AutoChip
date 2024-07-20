module top_module (
    input clk,
    input d,
    input r,
    output logic q
);

logic reg;

always@(posedge clk) begin
    if (r)
        reg <= 0;
    else
        reg <= d;
end

assign q = reg;

endmodule
