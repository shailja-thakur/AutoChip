module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    parameter A = 2'b01;
    parameter B = 2'b10;
    
    reg [1:0] state, next_state;

    // Sequential state transition
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Combinational logic for state transition
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
                next_state = A;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            A: z = x;
            B: z = ~x;
            default: z = 1'b0;
        endcase
    end

endmodule
