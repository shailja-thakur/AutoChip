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
    wire [2:0] sel;
    
    assign sel = {A, B, C};

    // 8-bit shift register
    always @(posedge clk) begin
        if (enable) begin
            Q <= {S, Q[7:1]};
        end
    end

    // Multiplexer logic
    always @(*) begin
        case (sel)
            3'b000: Z = Q[0];
            3'b001: Z = Q[1];
            3'b002: Z = Q[2];
            3'b011: Z = Q[3];
            3'b100: Z = Q[4];
            3'b101: Z = Q[5];
            3'b110: Z = Q[6];
            3'b111: Z = Q[7];
            default: Z = 1'b0; // Default case to handle all possible values of sel
        endcase
    end

endmodule
