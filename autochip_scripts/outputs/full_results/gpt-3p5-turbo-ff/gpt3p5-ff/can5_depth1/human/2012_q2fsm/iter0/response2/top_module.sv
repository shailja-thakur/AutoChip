module top_module (
	input clk,
	input reset,
	input w,
	output z
);

// Define state enumeration
typedef enum logic [2:0] {
    A,
    B,
    C,
    D,
    E,
    F
} state_type;

// Define state and next_state variables
state_type state, next_state;

// Define state flip-flops
always_ff @(posedge clk, posedge reset)
    if (reset)
        state <= A;
    else
        state <= next_state;

// Define state transition and output logic
always_comb
    case (state)
        A: begin
            if (w)
                next_state = B;
            else
                next_state = A;
            z = 0;
        end
        B: begin
            if (w)
                next_state = C;
            else
                next_state = D;
            z = 0;
        end
        C: begin
            if (w)
                next_state = E;
            else
                next_state = D;
            z = 0;
        end
        D: begin
            if (w)
                next_state = F;
            else
                next_state = A;
            z = 0;
        end
        E: begin
            if (w)
                next_state = E;
            else
                next_state = D;
            z = 1;
        end
        F: begin
            if (w)
                next_state = C;
            else
                next_state = D;
            z = 1;
        end
    endcase

endmodule
