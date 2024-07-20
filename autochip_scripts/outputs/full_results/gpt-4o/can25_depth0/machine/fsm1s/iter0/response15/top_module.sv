module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Define state parameters
    parameter A = 1'b0, B = 1'b1;
    
    // Define the state register
    reg state, next_state;

    // Combinational logic to determine the next state
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
            default: next_state = A; // default state
        endcase
    end
    
    // Sequential logic to update the state register
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= B; // Reset to state B
        else 
            state <= next_state;
    end

    // Update output
    always @(*) begin
        if (state == B)
            out = 1'b1;
        else
            out = 1'b0;
    end

endmodule
