module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

// State encoding
typedef enum reg [1:0] {
    S0 = 2'b00,  // Initial state
    S1 = 2'b01,  // First '1' detected
    S2 = 2'b10   // '10' detected
} state_t;

state_t state, next_state;

// State transition logic
always @(*) begin
    case (state)
        S0: begin
            if (x)
                next_state = S1;
            else
                next_state = S0;
        end
        S1: begin
            if (x)
                next_state = S1;
            else
                next_state = S2;
        end
        S2: begin
            if (x)
                next_state = S1;
            else
                next_state = S0;
        end
        default: next_state = S0;
    endcase
end

// State register
always @(negedge aresetn or posedge clk) begin
    if (!aresetn)
        state <= S0;
    else
        state <= next_state;
end

// Output logic
always @(*) begin
    case (state)
        S0: z = 1'b0;
        S1: z = 1'b0;
        S2: z = (x) ? 1'b1 : 1'b0;
        default: z = 1'b0;
    endcase
end

endmodule
