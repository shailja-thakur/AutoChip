module top_module (
    input clk,
    input in,
    input reset,
    output out
);

    parameter A = 1'b0, B = 1'b1;
    reg state;

    always @(posedge clk) begin
        if (reset) begin
            state <= B;
        end else begin
            case (state)
                A: begin
                    if (in) begin
                        state <= A;
                    end else begin
                        state <= B;
                    end
                end
                B: begin
                    if (in) begin
                        state <= B;
                    end else begin
                        state <= A;
                    end
                end
            endcase
        end
    end

    assign out = (state == B);

endmodule
