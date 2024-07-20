module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

parameter S = 2'b00;
parameter S1 = 2'b01;
parameter S10 = 2'b10;

reg [1:0] state, state_next;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn)
        state <= S;
    else
        state <= state_next;
end

always @(*) begin
    case (state)
        S: begin
            if (x == 1)
                state_next = S1;
            else
                state_next = S;
        end
        S1: begin
            if (x == 0)
                state_next = S10;
            else
                state_next = S1;
        end
        S10: begin
            if (x == 1)
                state_next = S1;
            else
                state_next = S;
        end
        default: state_next = S;
    endcase
end

always @(state) begin
    case (state)
        S, S1: z = 0;
        S10: z = x;
        default: z = 0;
    endcase
end

endmodule
