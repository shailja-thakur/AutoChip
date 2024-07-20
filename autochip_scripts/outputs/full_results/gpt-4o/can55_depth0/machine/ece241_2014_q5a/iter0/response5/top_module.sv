module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // State encoding using parameters
    parameter A = 2'b00, B = 2'b01, C = 2'b10;
    
    reg [1:0] state, next_state;
    
    // State transition logic
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
                    next_state = C;
                else
                    next_state = A;
            end
            B: begin
                if (x)
                    next_state = B;
                else
                    next_state = C;
            end
            C: begin
                if (x)
                    next_state = B;
                else
                    next_state = C;
            end
            default: next_state = A; // Default state
        endcase
    end

    // Output logic
    always @(*) begin
        if (state == C)
            z = 1'b1;
        else
            z = 1'b0;
    end

endmodule
