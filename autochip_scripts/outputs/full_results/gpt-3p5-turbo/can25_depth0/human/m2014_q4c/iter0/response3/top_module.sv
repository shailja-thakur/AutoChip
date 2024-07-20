module top_module (
    input clk,
    input d,
    input r,
    output logic q,
    output logic qbar
);

logic q_reg; // flip flop output
logic qbar_reg; // inverted flip flop output

always_ff @(posedge clk or posedge r)
begin
    if (r)
        q_reg <= 1'b0;
    else
        q_reg <= d;
end

assign q = q_reg;

assign qbar = ~q;

endmodule
