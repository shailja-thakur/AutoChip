module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);
    // State encoding
    typedef enum reg {OFF, ON} state_t;
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            OFF: next_state = j ? ON : OFF;
            ON:  next_state = k ? OFF : ON;
        endcase
    end

    // State update logic and output logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= OFF;
        end else begin
            state <= next_state;
        end
    end

    // Output logic (Moore machine: output depends on state only)
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            out <= 0;
        end else begin
            case (state)
                OFF: out <= 0;
                ON:  out <= 1;
            endcase
        end
    end
endmodule
