module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state;
wire next_state_A, next_state_B, next_state_C, next_state_D, next_state_E, next_state_F;
assign z = (state == 3'b100 || state == 3'b101) ? 1'b1 : 1'b0;

always @(posedge clk) begin
    if (reset) begin
        state <= 3'b000; // A
    end else begin
        case (state)
            3'b000: // A
                state <= w ? 3'b000 : 3'b001; // A or B
            3'b001: // B
                state <= w ? 3'b011 : 3'b010; // D or C
            3'b010: // C
                state <= w ? 3'b011 : 3'b100; // D or E
            3'b011: // D
                state <= w ? 3'b000 : 3'b101; // A or F
            3'b100: // E
                state <= w ? 3'b011 : 3'b100; // D or E
            3'b101: // F
                state <= w ? 3'b011 : 3'b110; // D or C
            default:
                state <= 3'b000; // A
        endcase
    end
end

endmodule
