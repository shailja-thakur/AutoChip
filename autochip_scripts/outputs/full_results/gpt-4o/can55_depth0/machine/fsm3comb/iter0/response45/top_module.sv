module top_module (
	input in,
	input [1:0] state,
	output reg [1:0] next_state,
	output out
);

    // Define states using local parameters for better readability
    localparam A = 2'b00;
    localparam B = 2'b01;
    localparam C = 2'b10;
    localparam D = 2'b11;

    // always_comb block to define state transitions
    always @(*) begin
        case (state)
            A: next_state = in ? B : A;
            B: next_state = in ? B : C;
            C: next_state = in ? D : A;
            D: next_state = in ? B : C;
            default: next_state = A;  // Default case to handle unspecified state
        endcase
    end
    
    // 'out' signal is high when the state machine is in state D
    assign out = (state == D);

endmodule
