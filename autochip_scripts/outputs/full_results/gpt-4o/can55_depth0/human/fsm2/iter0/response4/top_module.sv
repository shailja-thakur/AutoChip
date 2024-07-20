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
        ON  = 2'b01
    } state_t;

    // State and next case variable
    state_t current_state, next_state;

    // Output logic (Moore machine has state-dependent output)
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= OFF;
            out <= 1'b0;
        end else begin
            current_state <= next_state;
            out <= (next_state == ON);
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
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
            default: next_state = OFF;
        endcase
    end

endmodule
