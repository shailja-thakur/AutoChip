module top_module (
	input clk,
	input in,
	input areset,
	output out
);

// Declare states
typedef enum logic [1:0] {B, A} states;
states current_state, next_state;

// Declare outputs
reg out;

// Declare state register
always_ff @(posedge clk or posedge areset)
if (areset)
    current_state <= B;
else
    current_state <= next_state;

// Declare combinational logic
always_comb
case (current_state)
    B: begin
        if (in)
            next_state = B;
        else
            next_state = A;
        out = 1'b1;
    end
    A: begin
        if (in)
            next_state = A;
        else
            next_state = B;
        out = 1'b0;
    end
endcase

endmodule
