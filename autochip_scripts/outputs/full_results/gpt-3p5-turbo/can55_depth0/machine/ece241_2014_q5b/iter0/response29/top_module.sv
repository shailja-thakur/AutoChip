module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    parameter A = 1;
    parameter B = 0;

    reg state;

    always @(posedge clk) begin
        if (areset) begin
            state <= A;
        end else begin
            case (state)
                A: begin
                    if (x == 1) begin
                        state <= B;
                    end else begin
                        state <= A;
                    end
                end
                B: begin
                    state <= B;
                end
                default: begin
                    state <= A;
                end
            endcase
        end
    end

    always @(*) begin
        if ((state == A && x == 1) || (state == B && x == 0)) begin
            z = 1;
        end else begin
            z = 0;
        end
    end

endmodule
