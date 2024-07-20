module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    parameter A = 1'b0, B = 1'b1;

    // State register
    reg state, next_state;

    // Register for previous 'x' value to detect rising edge
    reg prev_x;

    // State transition on clock edge
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
            prev_x <= 0;
        end else begin
            state <= next_state;
            prev_x <= x;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (x && ~prev_x)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (~x && prev_x)
                    next_state = A;
                else
                    next_state = B;
            end
            default: next_state = A; // default state
        endcase
    end

    // Output logic
    always @(*) begin
        if ((state == A && x && ~prev_x) || (state == B && ~x && prev_x))
            z = 1;
        else
            z = 0;
    end

endmodule
