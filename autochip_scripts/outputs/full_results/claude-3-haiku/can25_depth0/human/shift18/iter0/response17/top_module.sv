module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q
);

always @(posedge clk) begin
    if (load) begin
        q <= data;
    end
    else if (ena) begin
        case (amount)
            2'b00: q <= {q[62:0], 1'b0};     // Shift left by 1 bit
            2'b01: q <= {q[55:0], 8'b0};     // Shift left by 8 bits
            2'b10: q <= {{1{q[63]}}, q[63:1]};   // Arithmetic right shift by 1 bit
            2'b11: q <= {{8{q[63]}}, q[63:8]};   // Arithmetic right shift by 8 bits
        endcase
    end
end

endmodule
