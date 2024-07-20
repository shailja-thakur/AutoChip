module top_module (
    input clk,
    input d,
    input ar,
    output logic q
);

always_ff @(posedge clk) begin
    if(ar)
        q <= 1'b0;
    else
        q <= d;
end

endmodule
