module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // Declare state register
    reg state;
    
    // State encoding
    parameter A = 1'b0, B = 1'b1;
    
    // Combinational logic block to determine next state
    reg next_state;
    
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
            default: next_state = A; // Default state to handle undefined behavior
        endcase
    end
    
    // Sequential logic to update state on rising edge of clk or reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B; // Initial state is B
        else
            state <= next_state;
    end
    
    // Assign output based on current state
    assign out = (state == B) ? 1'b1 : 1'b0;
    
endmodule
