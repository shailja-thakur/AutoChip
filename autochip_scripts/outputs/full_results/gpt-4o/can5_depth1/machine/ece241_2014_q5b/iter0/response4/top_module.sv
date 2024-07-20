module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // State declaration
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;

    // State register with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
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
            default: next_state = A;
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            A: begin
                z = x;
            end
            B: begin
                z = ~x;
            end
            default: z = 0;
        endcase
    end
    
endmodule
