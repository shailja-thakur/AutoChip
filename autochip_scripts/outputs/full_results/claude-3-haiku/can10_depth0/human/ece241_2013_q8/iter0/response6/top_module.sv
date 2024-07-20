module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, next_state;
parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;

always @(posedge clk, negedge aresetn) begin
    if (!aresetn) begin
        state <= S0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        S0: begin
            if (x == 1'b1) next_state = S1;
            else next_state = S0;
        end
        S1: begin
            if (x == 1'b0) next_state = S2;
            else next_state = S0;
        end
        S2: begin
            if (x == 1'b1) next_state = S1;
            else next_state = S0;
        end
        default: next_state = S0;
    endcase
end

always @(state) begin
    case (state)
        S0: z = 1'b0;
        S1: z = 1'b0;
        S2: z = 1'b1;
        default: z = 1'b0;
    endcase
end

endmodule
