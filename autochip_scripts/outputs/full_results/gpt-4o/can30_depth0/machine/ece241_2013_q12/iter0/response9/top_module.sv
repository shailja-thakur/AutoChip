module top_module (
    input clk,
    input enable,
    input S,
    input A,
    input B,
    input C,
    output reg Z
);
    reg [7:0] q;  // 8-bit register
    wire [2:0] mux_sel;
    
    // Combine A, B, C into a 3-bit address for the multiplexer
    assign mux_sel = {A, B, C};
    
    // Shift register logic
    always @(posedge clk) begin
        if (enable) begin
            q <= {q[6:0], S};  // Shift in S
        end
    end
    
    // 3-bit multiplexer
    always @(*) begin
        case (mux_sel)
            3'b000: Z = q[0];
            3'b001: Z = q[1];
            3'b010: Z = q[2];
            3'b011: Z = q[3];
            3'b100: Z = q[4];
            3'b101: Z = q[5];
            3'b110: Z = q[6];
            3'b111: Z = q[7];
            default: Z = 1'b0;
        endcase
    end

endmodule
