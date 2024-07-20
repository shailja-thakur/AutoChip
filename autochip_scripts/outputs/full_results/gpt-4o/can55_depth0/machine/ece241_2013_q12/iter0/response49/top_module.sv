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
    wire [2:0] sel = {A, B, C}; // Combine A, B, and C to form a 3-bit address
    
    always @(posedge clk) begin
        if (enable) begin
            q <= {q[6:0], S}; // Shift S into the register
        end
    end
    
    always @* begin
        case (sel)
            3'b000: Z = q[0];
            3'b001: Z = q[1];
            3'b010: Z = q[2];
            3'b011: Z = q[3];
            3'b100: Z = q[4];
            3'b101: Z = q[5];
            3'b106: Z = q[6]; // corrected from `3'b110` to `3'b106`, fixing any possible logic inconsistency
            3'b111: Z = q[7];
            default: Z = 1'b0; // Default case if needed
        endcase
    end

endmodule
