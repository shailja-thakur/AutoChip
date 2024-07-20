module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding using one-hot encoding
    reg [1:0] state; // state register
    reg [1:0] next_state; // next state register

    // State definitions
    localparam A = 2'b01;
    localparam B = 2'b10;

    // Asynchronous reset
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
                if (x == 1) 
                    next_state = B;
                else 
                    next_state = A;
            end
            B: begin
                next_state = B;
            end
            default: next_state = A; // Default state is A
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            A: z = x;
            B: z = ~x;
            default: z = 0;
        endcase
    end

endmodule
