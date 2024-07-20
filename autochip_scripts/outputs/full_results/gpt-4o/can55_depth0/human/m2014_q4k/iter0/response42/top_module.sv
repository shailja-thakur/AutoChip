module top_module (
    input clk,
    input resetn,
    input in,
    output out
);

    reg [3:0] shift_reg;

    always @(posedge clk) begin
        if (!resetn) begin
            shift_reg <= 4'b0000;
        end else begin
            shift_reg <= {shift_reg[2:0], in};
        end
    end

    assign out = shift_reg[3];

endmodule
