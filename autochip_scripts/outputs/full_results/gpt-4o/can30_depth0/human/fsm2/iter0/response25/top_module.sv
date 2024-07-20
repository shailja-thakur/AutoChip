module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

    // State encoding
    typedef enum logic [0:0] {
        OFF = 1'b0,
        ON  = 1'b1
    } state_t;

    state_t state, next_state;

    // Sequential logic for state transition
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= OFF;
        end else begin
            state <= next_state;
        end
    end

    // Combinational logic for next state
    always_comb begin
        case (state)
            OFF: if (j) next_state = ON; else next_state = OFF;
            ON:  if (k) next_state = OFF; else next_state = ON;
            default: next_state = OFF;
        endcase
    end

    // Output logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            out <= 1'b0;
        end else begin
            out <= (state == ON);
        end
    end

endmodule
