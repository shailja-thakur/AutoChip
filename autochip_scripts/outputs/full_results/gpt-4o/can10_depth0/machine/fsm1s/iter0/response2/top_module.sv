module top_module (
    input clk,
    input in,
    input reset,
    output out
);
    // Define the states
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;

    // Combinational logic block to determine the next state
    always @(*) begin
        case (state)
            A: begin
                if (in) 
                    next_state = A;
                else 
                    next_state = B;
            end
            
            B: begin
                if (in)
                    next_state = B;
                else
                    next_state = A;
            end

            default: next_state = A; // default case to avoid latches
        endcase
    end

    // Sequential block to update the state on the rising edge of clk
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B; // Initial state is B when reset is high
        else
            state <= next_state;
    end

    // The output is assigned the current state
    assign out = (state == B);

endmodule
