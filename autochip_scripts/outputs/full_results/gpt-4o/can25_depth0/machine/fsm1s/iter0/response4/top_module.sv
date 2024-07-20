module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    // State encoding
    parameter A = 1'b0;
    parameter B = 1'b1;

    // State register
    reg state, next_state;

    // Combinational logic block for next state logic
    always @(*) begin
        case (state)
            A: next_state = in ? A : B;
            B: next_state = in ? B : A;
            default: next_state = A;
        endcase
    end

    // Always block triggered on the rising edge of the clock
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= B;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    assign out = (state == B);

endmodule
