module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output out
);

    // State Encoding
    parameter A = 4'b0001, B = 4'b0010, C = 4'b0100, D = 4'b1000;

    always @(*) begin
        case (state)
            A: next_state = (in) ? B : A;
            B: next_state = (in) ? B : C;
            C: next_state = (in) ? D : A;
            D: next_state = (in) ? B : C;
            default: next_state = A; // default state if none matches
        endcase
    end

    assign out = (state == D);

endmodule
