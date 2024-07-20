module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    parameter A = 1'b0;
    parameter B = 1'b1;

    reg state;
    reg prev_x;
  
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
            prev_x <= 0;
        end else begin
            case (state)
                A: begin
                    if (x && !prev_x) begin
                        state <= B;
                    end
                    else begin
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
            prev_x <= x;
        end
    end

    always @(posedge clk) begin
        if ((state == A && x) || (state == B && !x))
            z <= 1;
        else
            z <= 0;
    end

endmodule
