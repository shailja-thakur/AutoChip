module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    // Define state constants
    localparam A = 1'b0;
    localparam B = 1'b1;

    // State register
    reg state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: begin
                if (j)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                if (k)
                    next_state = A;
                else
                    next_state = B;
            end
            default: next_state = A; // default to A if in an invalid state
        endcase
    end

    // Sequential logic to manage state register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    // Output logic
    always @(*) begin
        out = (state == B);
    end

endmodule
