module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg state, next_state;

// State transition logic
always @(posedge clk or negedge aresetn) begin
    if (!aresetn)
        state <= S;
    else
        state <= next_state;
end

// Output logic
always @(state or x) begin
    case (state)
        S: begin
            if (x == 0)
                next_state = S;
            else
                next_state = S1;
            z = 0;
        end
        S1: begin
            if (x == 0)
                next_state = S10;
            else
                next_state = S1;
            z = 0;
        end
        S10: begin
            if (x == 0)
                next_state = S;
            else
                next_state = S1;
            z = x;
        end
        default: begin
            next_state = S; // Default state
            z = 0; // Default output
        end
    endcase
end

endmodule
