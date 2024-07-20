module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

    // state definitions
    localparam A = 2'b00;
    localparam B = 2'b01;
    localparam C = 2'b10;
    localparam D = 2'b11;

    // Combinational logic for state transition
    always @(*) begin
        case (state)
            A: next_state = (in) ? B : A;
            B: next_state = (in) ? B : C;
            C: next_state = (in) ? D : A;
            D: next_state = (in) ? B : C;
            default: next_state = A;
        endcase
    end

    // Combinational logic for output
    assign out = (state == D) ? 1'b1 : 1'b0;

endmodule
