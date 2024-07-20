module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        OFF = 2'b00,
        ON = 2'b01
    } state_t;

    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            OFF: if (j) next_state = ON;
                 else next_state = OFF;
            ON: if (k) next_state = OFF;
                else next_state = ON;
            default: next_state = OFF;
        endcase
    end

    // State register and output logic
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= OFF;
            out <= 1'b0;
        end else begin
            state <= next_state;

            // Moore output depends only on current state
            case (state)
                OFF: out <= 1'b0;
                ON: out <= 1'b1;
                default: out <= 1'b0;
            endcase
        end
    end
endmodule
