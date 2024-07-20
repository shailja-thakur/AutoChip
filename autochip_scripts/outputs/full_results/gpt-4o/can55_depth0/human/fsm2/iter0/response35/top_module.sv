module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // State Declaration
    typedef enum reg [1:0] {
        OFF = 2'b00,
        ON = 2'b01
    } state_t;

    state_t state, next_state;

    // State Register
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= OFF;
        end else begin
            state <= next_state;
        end
    end

    // Next State Logic
    always @(*) begin
        case (state)
            OFF: if (j) next_state = ON;
                 else next_state = OFF;
            ON: if (k) next_state = OFF;
                else next_state = ON;
            default: next_state = OFF;
        endcase
    end

    // Output Logic
    always @(state) begin
        case (state)
            OFF: out = 0;
            ON: out = 1;
            default: out = 0;
        endcase
    end

endmodule
