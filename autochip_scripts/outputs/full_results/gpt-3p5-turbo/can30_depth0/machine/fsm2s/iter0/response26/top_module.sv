module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg [1:0] state;
reg [1:0] next_state;

// State initialization
always @(posedge clk or posedge reset)
begin
    if (reset)
        state <= 2'b00; // State A
    else
        state <= next_state;
end

// Next state logic
always @*
begin
    case(state)
        2'b00: // State A
            begin
                if (j)
                    next_state = 2'b01; // State B
                else
                    next_state = 2'b00; // State A
            end
        2'b01: // State B
            begin
                if (k)
                    next_state = 2'b00; // State A
                else
                    next_state = 2'b01; // State B
            end
        default: next_state = 2'b00; // Default State A 
    endcase
end

// Output logic
assign out = (state == 2'b01) ? 1'b1 : 1'b0;

endmodule
