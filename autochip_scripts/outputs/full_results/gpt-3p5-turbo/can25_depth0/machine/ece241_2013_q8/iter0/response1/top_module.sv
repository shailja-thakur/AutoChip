module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [3:0] state, next_state;

parameter S = 4'b000;
parameter S1 = 4'b001;
parameter S10 = 4'b010;

always @(posedge clk or negedge aresetn)
begin
    if (~aresetn)
        state <= S;
    else
        state <= next_state;
end

always @(state, x)
begin
    case (state)
        S: begin
            if (x == 1'b0)
                next_state = S;
            else
                next_state = S1;
        end
        
        S1: begin
            if (x == 1'b0)
                next_state = S10;
            else
                next_state = S1;
        end
        
        S10: begin
            if (x == 1'b0)
                next_state = S;
            else
                next_state = S1;
        end
    endcase
end

always @(state)
begin
    case (state)
        S, S1: z = 1'b0;
        S10: z = x;
    endcase
end

endmodule
