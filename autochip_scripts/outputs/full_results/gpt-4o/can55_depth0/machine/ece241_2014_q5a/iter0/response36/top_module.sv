module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // Define states using parameters
    parameter A = 2'b00, B = 2'b01, C = 2'b10;
    
    // State register
    reg [1:0] state, next_state;

    // Next state logic
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
            default: 
                next_state = A;
        endcase
    end

    // State register update and reset handling
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            z <= 1'b0;
        else
            z <= (state == C);
    end
endmodule
