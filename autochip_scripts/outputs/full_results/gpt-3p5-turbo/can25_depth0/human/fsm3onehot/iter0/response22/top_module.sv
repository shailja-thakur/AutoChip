module top_module (
	input in,
	input [3:0] state,
	output reg [3:0] next_state,
	output out
);

// State transition logic equations
always @(state, in)
    case(state)
        4'b0001: if(in) next_state = 4'b0010; else next_state = 4'b0001;
        4'b0010: if(in) next_state = 4'b0010; else next_state = 4'b0100;
        4'b0100: if(in) next_state = 4'b0001; else next_state = 4'b1000;
        4'b1000: if(in) next_state = 4'b0100; else next_state = 4'b0010;
    endcase

// Output logic equation
always @(state)
    case(state)
        4'b0001: out = 1'b0;
        4'b0010: out = 1'b0;
        4'b0100: out = 1'b0;
        4'b1000: out = 1'b1;
    endcase

endmodule
