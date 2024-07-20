module top_module (
    input clk,
    input in,
    output logic out
);

    // Internal register to hold the state of the output
    reg out_reg;

    // Assign the internal register to the output
    assign out = out_reg;

    // Initial block to set the initial value of out_reg
    initial begin
        out_reg = 0;
    end

    // Always block to describe the behavior on the positive edge of clk
    always @(posedge clk) begin
        out_reg <= in ^ out_reg;
    end
endmodule
