module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding using one-hot encoding
    reg [1:0] state, next_state;

    localparam A = 2'b01;
    localparam B = 2'b10;

    // State transition
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Next state logic and output logic
    always @(*) begin
        // Default values to avoid latches
        next_state = state;
        z = 0;

        case (state)
            A: begin
                if (x) begin
                    next_state = B;
                    z = 1;
                end else begin
                    next_state = A;
                    z = 0;
                end
            end

            B: begin
                if (x) begin
                    next_state = B;
                    z = 0;
                end else begin
                    next_state = B;
                    z = 1;
                end
            end

            default: next_state = A;  // Should never happen
        endcase
    end

endmodule
