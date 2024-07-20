module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    reg [1:0] state_next, state_current;

    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;

    always @(posedge clk or posedge areset)
    begin
        if (areset)
            state_current <= A;
        else
            state_current <= state_next;
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
                    state_next = B;
                else
                    state_next = B;
            end
        endcase
    end

    always @(posedge clk or posedge areset)
    begin
        if (areset)
            z <= 1'b0;
        else begin
            case (state_current)
                A: begin
                    if (x)
                        z <= 1'b1;
                    else
                        z <= 1'b0;
                end

                B: begin
                    if (x)
                        z <= 1'b0;
                    else
                        z <= 1'b1;
                end
            endcase
        end
    end

endmodule
