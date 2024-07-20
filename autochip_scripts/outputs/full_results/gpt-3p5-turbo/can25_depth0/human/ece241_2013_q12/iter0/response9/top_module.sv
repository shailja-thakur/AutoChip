module top_module (
    input clk,
    input enable,
    input S,
    input A,
    input B,
    input C,
    output reg Z
);

reg [7:0] Q;
reg [2:0] addr;
wire [7:0] D;
assign D = enable ? S : Q[7:0];

// 8-bit shift register
always @(posedge clk) begin
    if (enable)
        Q <= {S, Q[7:1]};
end

// 3x8 decoder
always @* begin
    case({A, B, C})
        3'b000: addr <= 3'b000;
        3'b001: addr <= 3'b001;
        3'b010: addr <= 3'b010;
        3'b011: addr <= 3'b011;
        3'b100: addr <= 3'b100;
        3'b101: addr <= 3'b101;
        3'b110: addr <= 3'b110;
        3'b111: addr <= 3'b111;
    endcase
end

// 8x1 MUX
always @* begin
    case(addr)
        3'b000: Z <= D[0];
        3'b001: Z <= D[1];
        3'b010: Z <= D[2];
        3'b011: Z <= D[3];
        3'b100: Z <= D[4];
        3'b101: Z <= D[5];
        3'b110: Z <= D[6];
        3'b111: Z <= D[7];
    endcase
end

endmodule
