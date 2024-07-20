module top_module (
    input clk,
    input enable,
    input S,
    input A,
    input B,
    input C,
    output reg Z
);
    // 8-bit shift register
    reg [7:0] Q;

    always @(posedge clk) begin
        if (enable) begin
            Q <= {S, Q[7:1]}; // Shift left, MSB is shifted in first
        end
    end

    // Multiplexer logic for output Z based on inputs A, B, C
    always @(*) begin
        case ({A, B, C})
            3'b000: Z = Q[0];
            3'b001: Z = Q[1];
            3'b010: Z = Q[2];
            3'b011: Z = Q[3];
            3'b100: Z = Q[4];
            3'b101: Z = Q[5];
            3'b110: Z = Q[6];
            3'b111: Z = Q[7];
            default: Z = 1'b0; // Default case, although it should never happen
        endcase
    end
endmodule
