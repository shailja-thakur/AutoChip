module top_module (
    input wire clk,
    input wire d,
    input wire r,
    output logic q
);

always @(posedge clk)
begin
    if(r == 1'b1)
        q <= 1'b0;
    else
        q <= d;
end

endmodule
