module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // One-hot encoding state definition
    reg [1:0] state, next_state; 
    parameter A = 2'b01,
              B = 2'b10;

    // State transition on clock edge
    always @(posedge clk or posedge areset) begin
        if (areset) 
            state <= A; // Reset to state A
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (x) 
                    next_state = B;
                else 
                    next_state = A;
            end
            B: begin
                next_state = B;
            end
            default: 
                next_state = A; // Default case for safety
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            A: z = x ? 1 : 0;
            B: z = x ? 0 : 1;
            default: z = 0;
        endcase
    end
endmodule
