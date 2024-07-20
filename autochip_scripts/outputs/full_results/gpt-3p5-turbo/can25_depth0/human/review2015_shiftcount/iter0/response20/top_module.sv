module top_module(
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output reg [3:0] q
);
    reg [3:0] shift_reg;

    // Shift Register Logic
    always @(posedge clk) begin
        if (shift_ena) begin
            shift_reg <= {shift_reg[2:0], data};
        end
        else if (count_ena) begin
            shift_reg <= shift_reg - 1;
        end
    end

    // Output Logic
    always @(posedge clk) begin
        q <= shift_reg;
    end
endmodule
