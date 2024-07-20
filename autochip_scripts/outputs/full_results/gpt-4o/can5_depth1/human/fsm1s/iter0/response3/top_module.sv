module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            B: next_state = in ? B : A;
            A: next_state = in ? A : B;
            default: next_state = B;
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            state <= B;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(*) begin
        case (state)
            B: out = 1'b1;
            A: out = 1'b0;
            default: out = 1'b1;
        endcase
    end

endmodule
