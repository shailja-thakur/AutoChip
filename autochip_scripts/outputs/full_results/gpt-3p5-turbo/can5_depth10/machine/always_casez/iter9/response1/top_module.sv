module top_module (
    input [7:0] in,
    output reg [2:0] pos
);

always @* begin
    case(in)
        8'b00000001: pos <= 3'b000;   // Use non-blocking assignment here
        8'b00000010: pos <= 3'b001;   // Use non-blocking assignment here
        8'b00000100: pos <= 3'b010;   // Use non-blocking assignment here
        8'b00001000: pos <= 3'b011;   // Use non-blocking assignment here
        8'b00010000: pos <= 3'b100;   // Use non-blocking assignment here
        8'b00100000: pos <= 3'b101;   // Use non-blocking assignment here
        8'b01000000: pos <= 3'b110;   // Use non-blocking assignment here
        8'b10000000: pos <= 3'b111;   // Use non-blocking assignment here
        default: pos <= 3'b000;       // Use non-blocking assignment here
    endcase
end

endmodule
