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
wire [2:0] abc;

// 8-bit shift register
always @(posedge clk) begin
    if (enable) begin
        Q <= {S, Q[7:1]};
    end
end

// Decode ABC to binary
always @* begin
    case ({A, B, C})
        3'b000: abc = 3'b000;
        3'b001: abc = 3'b001;
        3'b010: abc = 3'b010;
        3'b011: abc = 3'b011;
        3'b100: abc = 3'b100;
        3'b101: abc = 3'b101;
        3'b110: abc = 3'b110;
        3'b111: abc = 3'b111;
    endcase
end

// Mux for selecting output Z
always @* begin
    case (abc)
        3'b000: Z = Q[0];
        3'b001: Z = Q[1];
        3'b010: Z = Q[2];
        3'b011: Z = Q[3];
        3'b100: Z = Q[4];
        3'b101: Z = Q[5];
        3'b110: Z = Q[6];
        3'b111: Z = Q[7];
    endcase
end

endmodule
