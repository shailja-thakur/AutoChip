module top_module (
    input clk,
    input reset,
    input x,
    output reg z
);

    reg [2:0] state, next_state;
    parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100;

    always @(posedge clk) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

    always @(*) begin
        next_state = state;
        case (state)
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
        endcase
    end

    always @(*) begin
        z = (state == D || state == E);
    end

endmodule
