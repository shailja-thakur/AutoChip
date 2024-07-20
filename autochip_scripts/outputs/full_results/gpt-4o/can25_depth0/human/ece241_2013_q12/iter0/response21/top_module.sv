module top_module (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output reg Z
);

    // Internal 8-bit register
    reg [7:0] Q;

    // Shift register logic
    always @(posedge clk) begin
        if (enable) begin
            Q <= {Q[6:0], S}; // Shift in the input S
        end
    end

    // Address for multiplexer
    wire [2:0] select;
    assign select = {A, B, C};

    // Multiplexer logic to select appropriate Q bit
    always @(*) begin
        case (select)
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
