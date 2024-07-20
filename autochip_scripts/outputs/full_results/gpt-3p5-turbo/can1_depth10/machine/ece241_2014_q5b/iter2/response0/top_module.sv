module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    parameter A = 0;
    parameter B = 1;

    reg state;
    reg prev_x;
  
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            case (state)
                A: begin
                    if (x && !prev_x) begin
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
        prev_x <= x;
    end

    assign z = ((state == A) && x) || ((state == B) && ~x);

endmodule
