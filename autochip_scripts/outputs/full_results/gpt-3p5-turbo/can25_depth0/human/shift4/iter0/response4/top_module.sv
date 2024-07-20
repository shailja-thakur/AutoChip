module top_module(
    input clk,
    input areset,
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q
    );

    reg [3:0] shift_reg;

    always @(posedge clk or posedge areset) begin
        if (areset)
            shift_reg <= 4'b0000;
        else if (load)
            shift_reg <= data;
        else if (ena)
            shift_reg <= {shift_reg[2:0], 1'b0};
    end

    assign q = shift_reg;

endmodule
