module top_module (
    input clk,
    input enable,
    input S,
    input A,
    input B,
    input C,
    output reg Z
);
    
    reg [7:0] Q; // 8-bit shift register
    
    // Shift register logic
    always @(posedge clk) begin
        if (enable) 
            Q <= {S, Q[7:1]}; // Shift in MSB (S) and shift right
    end
    
    // Mux logic to select the correct output
    always @(*) begin
        case ({A, B, C}) // Combining A, B, and C to form a 3-bit select signal
            3'b000: Z = Q[0];
            3'b001: Z = Q[1];
            3'b010: Z = Q[2];
            3'b011: Z = Q[3];
            3'b100: Z = Q[4];
            3'b101: Z = Q[5];
            3'b110: Z = Q[6];
            3'b111: Z = Q[7];
            default: Z = 1'b0; // Default case to avoid latches
        endcase
    end
    
endmodule
