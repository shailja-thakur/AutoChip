module top_module (
    input clk,
    input enable,
    input S,
    input A,
    input B,
    input C,
    output reg Z
);

reg [7:0] Q;                    // Creating an 8-bit shift register with 8 D-type flip-flops

always @(posedge clk) begin     // Synchronous active high enable input controls shifting
    if(enable) begin
        Q <= {S, Q[7:1]};       // Shifting data into the shift register
    end
end

always @* begin                 // Multiplexer for selecting the output based on ABC
    case ({A,B,C})              // Using case statement for ABC combinations
        3'b000: Z = Q[0];
        3'b001: Z = Q[1];
        3'b010: Z = Q[2];
        3'b011: Z = Q[3];
        3'b100: Z = Q[4];
        3'b101: Z = Q[5];
        3'b110: Z = Q[6];
        3'b111: Z = Q[7];
        default: Z = 0;         // Default case for any invalid combination
    endcase
end

endmodule
