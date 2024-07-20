module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // Parameters for the states
    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;

    // State register
    reg [1:0] state, next_state;

    // State transition on clock or reset
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
            default: next_state = A;  // default state to handle undefined state
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            C: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule
