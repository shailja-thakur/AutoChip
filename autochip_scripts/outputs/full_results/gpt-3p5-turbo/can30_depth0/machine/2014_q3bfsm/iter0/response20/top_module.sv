module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

reg [2:0] state;
reg [2:0] next_state;

always @(posedge clk or posedge reset)
begin
    if (reset)
        state <= 3'b001;
    else
        state <= next_state;
end

always @(*)
begin
    case(state)
        3'b001: // State A
            begin
                if (x)
                    next_state = 3'b010; // Next state B
                else
                    next_state = 3'b001; // Next state A
            end
        3'b010: // State B
            begin
                if (x)
                    next_state = 3'b101; // Next state E
                else
                    next_state = 3'b010; // Next state B
            end
        3'b011: // State C
            begin
                if (x)
                    next_state = 3'b010; // Next state B
                else
                    next_state = 3'b011; // Next state C
            end
        3'b100: // State D
            begin
                if (x)
                    next_state = 3'b011; // Next state C
                else
                    next_state = 3'b010; // Next state B
            end
        3'b101: // State E
            begin
                if (x)
                    next_state = 3'b101; // Next state E
                else
                    next_state = 3'b100; // Next state D
            end
        default: next_state = 3'b001; // Default state A
    endcase
end

always @(state)
begin
    if (state == 3'b101 || state == 3'b110)
        z = 1'b1;
    else
        z = 1'b0;
end

endmodule
