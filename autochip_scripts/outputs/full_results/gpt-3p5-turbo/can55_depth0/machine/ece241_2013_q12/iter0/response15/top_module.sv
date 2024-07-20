module top_module (
    input clk,
    input enable,
    input S,
    input A,
    input B,
    input C,
    output reg Z
);
    reg [7:0] q; // 8-bit register
    
    always @(posedge clk) begin
        if (enable) begin
            q <= {S, q[7:1]}; // shift input S into the register
        end
    end
    
    always @* begin
        case ({A, B, C})
            3'b000: Z = q[0]; // select bit 0 of the register
            3'b001: Z = q[1]; // select bit 1 of the register
            3'b010: Z = q[2]; // select bit 2 of the register
            3'b011: Z = q[3]; // select bit 3 of the register
            3'b100: Z = q[4]; // select bit 4 of the register
            3'b101: Z = q[5]; // select bit 5 of the register
            3'b110: Z = q[6]; // select bit 6 of the register
            3'b111: Z = q[7]; // select bit 7 of the register
        endcase
    end
endmodule
