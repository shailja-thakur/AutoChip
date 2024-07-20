module top_module (
	input clk,
	input reset,
	input w,
	output z
);

reg [2:0] state;
reg z;

always @(posedge clk or posedge reset)
begin
    if (reset)
        state <= 3'b000;
    else if (w)
    begin
        case(state)
            3'b000: state <= 3'b001;  // A to B
            3'b001: state <= 3'b010;  // B to C
            3'b010: state <= 3'b100;  // C to E
            3'b011: state <= 3'b111;  // D to F
            3'b100: state <= 3'b100;  // E to E
            3'b101: state <= 3'b110;  // F to C
            default: state <= 3'b000;  // Default to A
        endcase
    end
    else
    begin
        case(state)
            3'b001: state <= 3'b011;  // B to D
            3'b010: state <= 3'b011;  // C to D
            3'b011: state <= 3'b000;  // D to A
            3'b100: state <= 3'b010;  // E to D
            3'b101: state <= 3'b011;  // F to D
            default: state <= 3'b000;  // Default to A
        endcase
    end
end

always @(state)
begin
    if (state == 3'b100 || state == 3'b101)  // E or F
        z = 1;
    else
        z = 0;
end

endmodule
