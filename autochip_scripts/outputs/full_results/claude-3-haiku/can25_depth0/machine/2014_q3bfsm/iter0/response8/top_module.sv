module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

reg [2:0] current_state, next_state;

localparam A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3, E = 3'd4;

always @(posedge clk or posedge reset) begin
    if (reset)
        current_state <= A;
    else
        current_state <= next_state;
end

always @(*) begin
    case (current_state)
        A: begin
            if (x)
                next_state = B;
            else
                next_state = A;
        end
        B: begin
            if (x)
                next_state = E;
            else
                next_state = B;
        end
        C: begin
            if (x)
                next_state = B;
            else
                next_state = C;
        end
        D: begin
            if (x)
                next_state = C;
            else
                next_state = B;
        end
        E: begin
            if (x)
                next_state = E;
            else
                next_state = D;
        end
        default:
            next_state = A;
    endcase
end

always @(*) begin
    z = (current_state == D || current_state == E);
end

endmodule
