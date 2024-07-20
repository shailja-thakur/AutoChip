module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

// Define the states as constants
parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

// Define the internal state
reg [1:0] state;

always @(posedge clk or posedge reset)
begin
    if (reset)
        state <= A;
    else
    begin
        case (state)
            A: if (in) state <= B; else state <= A;
            B: if (in) state <= C; else state <= B;
            C: if (in) state <= A; else state <= D;
            D: if (in) state <= B; else state <= C;
        endcase
    end
end

always @(state)
begin
    case (state)
        A: out <= 1'b0;
        D: out <= 1'b1;
        default: out <= 1'b0;
    endcase
end

endmodule
