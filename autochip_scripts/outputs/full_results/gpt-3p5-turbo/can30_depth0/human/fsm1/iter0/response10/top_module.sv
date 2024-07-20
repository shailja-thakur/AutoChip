module top_module (
    input clk,
    input in,
    input areset,
    output out
);

// Declare the states as parameters
parameter B = 0;
parameter A = 1;

// Declare the state variable and initialize it to state B
reg [1:0] state = B;

// Declare the next state variable
reg [1:0] next_state;

// Declare the output variable
reg out;

// State transition and output logic
always @(posedge clk or posedge areset) begin
    if (areset)
        state <= B;
    else
        state <= next_state;

    case (state)
        B: begin
            // State B transitions
            if (in == 1'b0)
                next_state = A;
            else
                next_state = B;

            // State B output
            out = 1'b1;
        end

        A: begin
            // State A transitions
            if (in == 1'b0)
                next_state = B;
            else
                next_state = A;

            // State A output
            out = 1'b0;
        end
    endcase
end

endmodule
