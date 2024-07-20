module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    parameter A = 0;
    parameter B = 1;
    reg state;

    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= A;
        end
        else begin
            case (state)
                A: begin
                    if (x) begin
                        state <= B;
                    end
                    else begin
                        state <= A;
                    end
                end
                B: begin
                    state <= B;
                end
            endcase
        end
    end

    always @(*) begin
        if ((state == A && x) || (state == B && !x)) begin
            z = 1;
        end
        else begin
            z = 0;
        end
    end

endmodule
