module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

reg [1:0] current_state, next_state;

parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;

always @(posedge clk) begin
    current_state <= next_state;
end

always @(*) begin
    case (current_state)
        S0: begin
            if (a == 0 && b == 0) begin
                next_state = S0;
                q = 0;
                state = 0;
            end
            else if (a == 0 && b == 1) begin
                next_state = S1;
                q = 0;
                state = 0;
            end
            else if (a == 1 && b == 0) begin
                next_state = S0;
                q = 0;
                state = 0;
            end
            else if (a == 1 && b == 1) begin
                next_state = S2;
                q = 1;
                state = 0;
            end
        end
        S1: begin
            next_state = S0;
            q = 1;
            state = 1;
        end
        S2: begin
            next_state = S0;
            q = 0;
            state = 1;
        end
        default: begin
            next_state = S0;
            q = 0;
            state = 0;
        end
    endcase
end

endmodule
