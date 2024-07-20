module top_module (
    input clk,
    input in,
    input reset,
    output out
);

// Define the states
typedef enum logic [1:0] {
    A,
    B,
    C,
    D
} state_type;

// Define the state register
reg state_reg;

// Define the next state register
reg next_state_reg;

// Define the output register
reg out_reg;

// Define the output wire
wire out;

// Define the state transition logic and output logic
always_ff @(posedge clk, posedge reset)
if (reset)
    state_reg <= A;
else
    state_reg <= next_state_reg;

always_comb
case (state_reg)
    A: begin
        if (in)
            next_state_reg = B;
        else
            next_state_reg = A;
        out_reg = 0;
    end
    B: begin
        if (in)
            next_state_reg = C;
        else
            next_state_reg = B;
        out_reg = 0;
    end
    C: begin
        if (in)
            next_state_reg = A;
        else
            next_state_reg = D;
        out_reg = 0;
    end
    D: begin
        if (in)
            next_state_reg = C;
        else
            next_state_reg = B;
        out_reg = 1;
    end
endcase

// Assign output
assign out = out_reg;

endmodule
