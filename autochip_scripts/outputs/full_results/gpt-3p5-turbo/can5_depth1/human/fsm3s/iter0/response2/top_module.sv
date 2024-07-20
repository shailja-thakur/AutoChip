module top_module (
	input clk,
	input in,
	input reset,
	output out
);

// Declare states as enum
typedef enum logic [1:0] {A, B, C, D} state_type;

// Declare state variable
state_type current_state, next_state;

// Declare output variable
logic out_reg;

// Declare state transition and output equations
always @(posedge clk, posedge reset) begin
    if (reset)
        current_state <= A;
    else
        current_state <= next_state;
        
    case (current_state)
        A: begin
            if (in)
                next_state = B;
            else
                next_state = A;
            out_reg = 0;
        end
        B: begin
            if (in)
                next_state = B;
            else
                next_state = C;
            out_reg = 0;
        end
        C: begin
            if (in)
                next_state = D;
            else
                next_state = A;
            out_reg = 0;
        end
        D: begin
            if (in)
                next_state = B;
            else
                next_state = C;
            out_reg = 1;
        end
    endcase
end

// Output assignment
assign out = out_reg;

endmodule
