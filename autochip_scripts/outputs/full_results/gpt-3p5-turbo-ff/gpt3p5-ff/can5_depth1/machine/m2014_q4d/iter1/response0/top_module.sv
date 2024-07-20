module top_module (
    input clk,
    input in,
    output logic out
);
reg out_reg; // add a reg to store the previous value of out

always_ff @(posedge clk) begin
    out_reg <= out; // store the previous value of out
    out <= in ^ out_reg; // use the stored previous value of out
end

endmodule
