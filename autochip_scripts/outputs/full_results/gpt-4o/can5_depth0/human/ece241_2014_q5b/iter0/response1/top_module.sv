module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    
    // State encoding using one-hot encoding
    reg [1:0] state, next_state;

    // State encoding
    localparam [1:0]
        A = 2'b01,
        B = 2'b10;

    // Combinational logic for state transition
    always @(*) begin
        case (state)
            A: if (x) next_state = B;
               else next_state = A;
            B: next_state = B;
        endcase
    end

    // Combinational logic for output
    always @(*) begin
        case (state)
            A: z = x;
            B: z = ~x;
            default: z = 1'b0;
        endcase
    end

    // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

endmodule
