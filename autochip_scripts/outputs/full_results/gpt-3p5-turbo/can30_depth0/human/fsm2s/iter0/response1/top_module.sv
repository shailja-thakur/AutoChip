module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);

// State enumeration
typedef enum logic [1:0] {OFF, ON} state_e;

// State signals
reg state, next_state;

// Output signal
reg out_reg;

always_ff @(posedge clk, posedge reset)
begin
    if (reset)
        state <= OFF; // Reset the state to OFF when reset is active high
    else
        state <= next_state; // Update the state based on next_state value
end

always_comb
begin
    out = out_reg; // Assign the output value to out_reg
    
    case(state)
        OFF:
            begin
                if (j)
                    next_state = ON;
                else
                    next_state = OFF;
            end
        ON:
            begin
                if (k)
                    next_state = OFF;
                else
                    next_state = ON;
            end
        default:
            next_state = OFF; // Default state is OFF
    endcase
end

always_ff @(posedge clk)
begin
    case(state)
        OFF:
            out_reg <= 1'b0; // Output is 0 when the state is OFF
        ON:
            out_reg <= 1'b1; // Output is 1 when the state is ON
    endcase
end

endmodule
