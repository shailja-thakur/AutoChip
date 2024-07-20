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
    reg [2:0] addr; // 3-bit address from A, B, and C
    
    always @(posedge clk) begin
        if (enable) begin
            q <= {q[6:0], S}; // Shift S into the register
        end
    end
    
    always @(*) begin
        addr = {A, B, C}; // form the 3-bit address
        Z = q[addr]; // select the bit of the register for output
    end
    
endmodule
