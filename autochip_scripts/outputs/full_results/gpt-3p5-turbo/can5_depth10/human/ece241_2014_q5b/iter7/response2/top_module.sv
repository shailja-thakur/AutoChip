module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    reg [1:0] state_next, state_current;

    parameter A = 2'b00;
    parameter B = 2'b01;

    always @(posedge clk or posedge areset)
    begin
        if (areset)
        begin
            state_current <= A;
            z <= 1'b0;
        end
        else
        begin
            state_current <= state_next;
            if (state_current == B)
                z <= ~x;
            else
                z <= x;
        end
    end

    always @(state_current or x)
    begin
        case (state_current)
            A: begin
                if (x)
                    state_next = B;
                else
                    state_next = A;
            end

            B: begin
                if (x)
                    state_next = A;
                else
                    state_next = B;
            end
        endcase
    end

endmodule
