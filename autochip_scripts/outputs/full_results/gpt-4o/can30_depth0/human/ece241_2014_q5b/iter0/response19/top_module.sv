module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding with one-hot
    reg [1:0] state, next_state;
    localparam A = 2'b01;
    localparam B = 2'b10;

    // State transition
    always @(*) begin
        case (state)
            A: 
                if (x)
                    next_state = B;
                else
                    next_state = A;
            B: 
                if (x)
                    next_state = B;
                else
                    next_state = B;
            default: 
                next_state = A;
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

    // State register with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

endmodule
