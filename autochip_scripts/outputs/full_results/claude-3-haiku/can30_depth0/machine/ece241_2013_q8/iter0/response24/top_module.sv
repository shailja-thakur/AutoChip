module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

reg [1:0] state, state_next;
parameter S = 2'b00, S1 = 2'b01, S10 = 2'b10;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= S;
    end
    else begin
        state <= state_next;
    end
end

always @(*) begin
    case(state)
        S: begin
            if (x == 0) begin
                state_next = S;
            end
            else begin
                state_next = S1;
            end
            z = 0;
        end
        S1: begin
            if (x == 0) begin
                state_next = S10;
            end
            else begin
                state_next = S1;
            end
            z = 0;
        end
        S10: begin
            if (x == 0) begin
                state_next = S;
            end
            else begin
                state_next = S1;
            end
            z = x;
        end
        default: begin
            state_next = S;
            z = 0;
        end
    endcase
end

endmodule
