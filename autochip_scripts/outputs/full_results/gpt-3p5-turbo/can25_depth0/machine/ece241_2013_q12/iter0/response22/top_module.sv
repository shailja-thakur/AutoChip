module top_module (
    input clk,
    input enable,
    input S,
    input A,
    input B,
    input C,
    output reg Z
);

reg [7:0] q; // 8-bit shift register
wire [2:0] address; // 3-bit address for multiplexer

always @(posedge clk) begin
    if (enable) begin
        q <= {S, q[7:1]}; // Shift in S input when enable is high
    end
end

assign address = {A, B, C}; // Combine A, B, and C to form address

always @(address) begin
    case(address)
        3'b000 : Z <= q[0]; // Output bit 0 when address is 000
        3'b001 : Z <= q[1]; // Output bit 1 when address is 001
        3'b010 : Z <= q[2]; // Output bit 2 when address is 010
        3'b011 : Z <= q[3]; // Output bit 3 when address is 011
        3'b100 : Z <= q[4]; // Output bit 4 when address is 100
        3'b101 : Z <= q[5]; // Output bit 5 when address is 101
        3'b110 : Z <= q[6]; // Output bit 6 when address is 110
        3'b111 : Z <= q[7]; // Output bit 7 when address is 111
        default : Z <= 1'b0; // Default value when address is invalid
    endcase
end

endmodule
