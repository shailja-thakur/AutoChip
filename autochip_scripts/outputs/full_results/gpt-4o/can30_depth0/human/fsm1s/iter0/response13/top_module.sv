module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            B: if (in) next_state = B; else next_state = A;
            A: if (in) next_state = A; else next_state = B;
            default: next_state = B; // default state should be reset state
        endcase
    end

    // State register
    always @(posedge clk) begin
        if (reset)
            state <= B;
        else
            state <= next_state;
    end

    // Output logic
    always @(posedge clk) begin
        if (reset)
            out <= 1;
        else begin
            case (state)
                B: out <= 1;
                A: out <= 0;
                default: out <= 1; // default output should be reset state's output
            endcase
        end
    end

endmodule
