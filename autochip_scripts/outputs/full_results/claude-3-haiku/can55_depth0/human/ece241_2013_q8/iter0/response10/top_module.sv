module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

localparam S0 = 2'd0, S1 = 2'd1, S2 = 2'd2; // 3 states

reg [1:0] state, next_state;

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
            if (~x)
                next_state = S0;
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

// Output logic
always @(*) begin
    case (state)
        S2: z = 1'b1; // Sequence "101" detected
        default: z = 1'b0;
    endcase
end

// State register
always @(posedge clk or negedge aresetn) begin
    if (~aresetn)
        state <= S0;
    else
        state <= next_state;
end

endmodule
