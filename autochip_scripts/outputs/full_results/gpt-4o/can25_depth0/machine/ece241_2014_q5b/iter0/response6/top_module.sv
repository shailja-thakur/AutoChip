module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // Define states
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;

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
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                next_state = B;
            end
            default: begin
                next_state = A;
            end
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            A: begin
                if (x)
                    z = 1'b1;
                else
                    z = 1'b0;
            end
            B: begin
                if (!x)
                    z = 1'b1;
                else
                    z = 1'b0;
            end
            default: begin
                z = 1'b0;
            end
        endcase
    end

endmodule
