module top_module (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output reg Z
);
    reg [7:0] q; // 8-bit shift register
    wire [2:0] sel; // 3-bit address for the multiplexer

    // Combine A, B, and C to form the 3-bit address for selection
    assign sel = {A, B, C};

    always @(posedge clk) begin
        if (enable) begin
            // Shift the S input into the register
            q <= {q[6:0], S};
        end
    end

    always @(*) begin
        // Use the 3-bit address to select which bit of the register is output
        case (sel)
            3'b000: Z = q[0];
            3'b001: Z = q[1];
            3'b010: Z = q[2];
            3'b011: Z = q[3];
            3'b100: Z = q[4];
            3'b101: Z = q[5];
            3'b110: Z = q[6];
            3'b111: Z = q[7];
            default: Z = 1'b0; // Default case for safety
        endcase
    end

endmodule
