module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output reg out
);

    // Parameters for state encoding
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;

    // Combinational logic for next state and output
    always @(*) begin
        case(state)
            A: begin
                if (in == 1'b0) next_state = A;
                else next_state = B;
                out = 1'b0;
            end
            B: begin
                if (in == 1'b0) next_state = C;
                else next_state = B;
                out = 1'b0;
            end
            C: begin
                if (in == 1'b0) next_state = A;
                else next_state = D;
                out = 1'b0;
            end
            D: begin
                if (in == 1'b0) next_state = C;
                else next_state = B;
                out = 1'b1;
            end
            default: begin
                next_state = A; // Default to state A for undefined states
                out = 1'b0;
            end
        endcase
    end

endmodule
