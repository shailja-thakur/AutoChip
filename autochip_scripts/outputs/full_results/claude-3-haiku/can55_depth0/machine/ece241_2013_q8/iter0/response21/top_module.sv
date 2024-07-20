module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;
parameter S = 2'b00, S1 = 2'b01, S10 = 2'b10;

// State transition logic
always @(*) begin
    case (state)
        S: begin
            if (x == 0) next_state = S;
            else next_state = S1;
        end
        S1: begin
            if (x == 0) next_state = S10;
            else next_state = S1;
        end
        S10: begin
            if (x == 0) next_state = S;
            else next_state = S1;
        end
        default: next_state = S;
    endcase
end

// Output logic
always @(*) begin
    case (state)
        S: z = 0;
        S1: z = 0;
        S10: z = x;
        default: z = 0;
    endcase
end

// State register
always @(posedge clk or negedge aresetn) begin
    if (!aresetn)
        state <= S;
    else
        state <= next_state;
end

endmodule
