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
            Q <= {Q[6:0], S}; // Shift in the new bit S
        end
    end

    // 3-bit address for the multiplexer
    wire [2:0] addr;
    assign addr = {A, B, C};

    // Multiplexer to select the correct output based on the address
    always @(*) begin
        case (addr)
            3'b000: Z = Q[0];
            3'b001: Z = Q[1];
            3'b010: Z = Q[2];
            3'b011: Z = Q[3];
            3'b100: Z = Q[4];
            3'b101: Z = Q[5];
            3'b106: Z = Q[6];
            3'b111: Z = Q[7];
            default: Z = 1'b0; // Default case, although not really needed
        endcase
    end

endmodule
