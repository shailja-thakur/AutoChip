module top_module (
    input clk,
    input d,
    input ar,
    output logic q
);

reg q;

always @(posedge clk or negedge ar)
begin
    if (!ar)
        q <= 0;
    else
        q <= d;
end

endmodule
