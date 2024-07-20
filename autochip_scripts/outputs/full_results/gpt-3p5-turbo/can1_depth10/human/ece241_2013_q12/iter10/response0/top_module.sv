module top_module (
    input wire clk,
    input wire enable,
    input wire S,
    input wire A,
    input wire B,
    input wire C,
    output reg Z
);

    reg [7:0] Q;
    reg [2:0] address;

    always @(posedge clk) begin
        if (enable) begin
            Q <= {S, Q[6:0]}; // Corrected range of Q[7:1] to Q[6:0]
        end
        case ({A,B,C})
            3'b000: address <= 3'b000;
            3'b001: address <= 3'b001;
            3'b010: address <= 3'b010;
            3'b011: address <= 3'b011;
            3'b100: address <= 3'b100;
            3'b101: address <= 3'b101;
            3'b110: address <= 3'b110;
            3'b111: address <= 3'b111;
            default: address <= 3'b000; // Add a default case to handle invalid inputs
        endcase

        Z <= Q[address];
    end

endmodule
