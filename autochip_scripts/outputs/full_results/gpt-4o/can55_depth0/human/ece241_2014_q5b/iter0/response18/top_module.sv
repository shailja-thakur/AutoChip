module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    // State definitions using one-hot encoding
    reg [1:0] state, next_state;
    localparam A = 2'b01, B = 2'b10;

    // State transition logic
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (x == 1'b0)
                    next_state = A;
                else
                    next_state = B;
            end
            B: begin
                next_state = B;
            end
            default: next_state = A; // Default to state A on invalid state
        endcase
    end

    // Output logic
    assign z = (state == A) ? x : ~x;

endmodule
