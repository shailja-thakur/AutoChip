module top_module (
    input clk,
    input enable,
    input S,
    input [2:0] A,
    input [2:0] B,
    input [2:0] C,
    output reg Z
);
 
reg [7:0] q;
reg [2:0] address;

always @(posedge clk) begin
    if (enable) begin
        q <= {q[6:0], S};
    end
end

always @(A or B or C) begin
    case({A, B, C})
        3'b000: address <= 3'b000;
        3'b001: address <= 3'b001;
        3'b010: address <= 3'b010;
        3'b011: address <= 3'b011;
        3'b100: address <= 3'b100;
        3'b101: address <= 3'b101;
        3'b110: address <= 3'b110;
        3'b111: address <= 3'b111;
    endcase
end

always @(posedge clk) begin
    Z <= q[address];
end

endmodule
