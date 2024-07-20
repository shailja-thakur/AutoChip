module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;
    
    state_t state, next_state;

    // Combinational logic to determine next state
    always @(*) begin
        case (state)
            A: if (j) 
                   next_state = B;
               else 
                   next_state = A;
            B: if (k) 
                   next_state = A;
               else 
                   next_state = B;
            default: next_state = A;
        endcase
    end

    // Clocked always block to update state
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            out <= 1'b0;
        else if (state == B)
            out <= 1'b1;
        else
            out <= 1'b0;
    end

endmodule
