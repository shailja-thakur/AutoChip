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

// State register
state_t state, next_state;

// Combinational logic for state transition
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
        default: next_state = OFF;
    endcase
end

// Sequential logic for state update
always @(posedge clk or posedge areset) begin
    if (areset) 
        state <= OFF;
    else
        state <= next_state;
end

// Output logic
always @(posedge clk or posedge areset) begin
    if (areset)
        out <= 1'b0;
    else
        case (state)
            OFF: out <= 1'b0;
            ON: out <= 1'b1;
            default: out <= 1'b0;
        endcase
end

endmodule
