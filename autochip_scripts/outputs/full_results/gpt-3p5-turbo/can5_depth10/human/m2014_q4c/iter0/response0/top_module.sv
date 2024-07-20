module top_module (
    input clk,
    input d,
    input r,
    output logic q
);

// Internal signal for the flip flop
logic q_internal;

always_ff @(posedge clk or posedge r)
begin
    if (r)
        q_internal <= 0;
    else
        q_internal <= d;
end

assign q = q_internal;

endmodule
