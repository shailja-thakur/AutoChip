module top_module (
    input clk,
    input enable,
    input S,
    input A,
    input B,
    input C,
    output reg [7:0] q,
    output reg Z
);

reg [7:0] shift_reg;
reg [2:0] address;

always @(posedge clk) begin
    if (enable) begin
        shift_reg <= shift_reg << 1;
        shift_reg[0] <= S;
    end
    address <= {A, B, C};
    Z <= shift_reg[address];
end

endmodule
