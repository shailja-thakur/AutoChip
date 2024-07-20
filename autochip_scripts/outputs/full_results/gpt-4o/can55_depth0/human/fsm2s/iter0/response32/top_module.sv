module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);
    // State encoding
    typedef enum reg [1:0] {
        OFF = 2'b00,
        ON = 2'b01
    } state_t;

    state_t state, next_state;

    // Sequential logic for state transition
    always @(posedge clk) begin
        if (reset) begin
            state <= OFF;
        end else begin
            state <= next_state;
        end
    end

    // Combinational logic for next state
    always @(*) begin
        case (state)
            OFF: begin
                if (j)
                    next_state = ON;
                else
                    next_state = OFF;
            end
            ON: begin
                if (k)
                    next_state = OFF;
                else
                    next_state = ON;
            end
            default: next_state = OFF; // Default to OFF state
        endcase
    end

    // Output logic based on state
    assign out = (state == ON);

endmodule
