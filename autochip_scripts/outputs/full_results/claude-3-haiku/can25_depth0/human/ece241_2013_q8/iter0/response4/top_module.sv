module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

parameter [1:0] S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;
reg [1:0] current_state, next_state;

always @(posedge clk, negedge aresetn) begin
    if (~aresetn)
        current_state <= S0;
    else
        current_state <= next_state;
end

always @(*) begin
    z = 1'b0;
    case (current_state)
        S0: begin
            if (x)
                next_state = S1;
            else
                next_state = S0;
        end
        S1: begin
            if (~x)
                next_state = S2;
            else
                next_state = S1;
        end
        S2: begin
            if (x) begin
                next_state = S1;
                z = 1'b1;
            end
            else
                next_state = S0;
        end
        default:
            next_state = S0;
    endcase
end

endmodule
