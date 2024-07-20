module top_module (
    input clk,
    input d,
    input ar,
    output logic q
);

// D flip flop, positive edge triggered
always_ff @(posedge clk or negedge ar)
begin
    if (!ar)
        q <= 1'b0; // asynchronous reset
    else
        q <= d; // store input value on positive edge
end

endmodule
