module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    // State definitions
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;

    // Combinational logic to determine next state
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
        endcase
    end

    // State register update on the rising edge of the clock
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= B;  // Reset to initial state B
        else
            state <= next_state;
    end
    
    // Output logic
    assign out = (state == B) ? 1'b1 : 1'b0;

endmodule
