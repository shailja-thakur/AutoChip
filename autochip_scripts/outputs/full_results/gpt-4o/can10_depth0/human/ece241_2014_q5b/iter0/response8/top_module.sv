module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    localparam A = 2'b01, B = 2'b10;
    
    // State variables
    reg [1:0] state, next_state;

    // State transition
    always @(*) begin
        case (state)
            A: if (x == 1) next_state = B;
               else next_state = A;
            B: if (x == 1) next_state = B;
               else next_state = B;
            default: next_state = A; // Default to reset state for safety
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            A: if (x == 1) z = 1;
               else z = 0;
            B: if (x == 1) z = 0;
               else z = 1;
            default: z = 0;
        endcase
    end

    // State register
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

endmodule
