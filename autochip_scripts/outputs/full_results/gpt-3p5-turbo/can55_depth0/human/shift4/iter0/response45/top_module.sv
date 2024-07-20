module top_module(
    input clk,
    input areset,
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q);

    reg [3:0] shift_reg;

    always @(posedge clk or posedge areset) begin
        if (areset == 1)
            shift_reg <= 4'b0;
        else begin
            if (load == 1)
                shift_reg <= data;
            else if (ena == 1)
                shift_reg <= {shift_reg[2:0], 1'b0};
        end
    end

    assign q = shift_reg;

endmodule
