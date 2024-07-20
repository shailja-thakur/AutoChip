module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // Define parameters for states
    parameter A = 2'b00, 
              B = 2'b01, 
              C = 2'b10;

    // Register to keep the state
    reg [1:0] state, next_state;

    // State transition logic (combinational)
    always @(*) begin
        case (state)
            A: if (x) 
                   next_state = C;
               else 
                   next_state = A;
            B: if (x) 
                   next_state = B;
               else 
                   next_state = C;
            C: if (x) 
                   next_state = B;
               else 
                   next_state = C;
            default: next_state = A; // Default case to cover unforeseen states
        endcase
    end

    // State register update (sequential)
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        z = (state == C);
    end

endmodule
