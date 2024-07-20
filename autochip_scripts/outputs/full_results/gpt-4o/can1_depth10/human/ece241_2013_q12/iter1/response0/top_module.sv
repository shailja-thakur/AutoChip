module top_module (
    input clk,
    input enable,
    input S,
    input [2:0] ABC,
    output reg Z
);
    reg [7:0] Q;

    // Shift register logic
    always @(posedge clk) begin
        if (enable) begin
            Q <= {S, Q[7:1]};  // Shift in the new bit S
        end
    end

    // Logic to output Q based on ABC
    always @(*) begin
        case (ABC)
            3'b000: Z = Q[0];
            3'b001: Z = Q[1];
            3'b010: Z = Q[2];
            3'b011: Z = Q[3];
            3'b100: Z = Q[4];
            3'b101: Z = Q[5];
            3'b110: Z = Q[6];
            3'b111: Z = Q[7];
            default: Z = 1'b0;
        endcase
    end
endmodule
