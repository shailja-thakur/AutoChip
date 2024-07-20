module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            q <= 0;
            state <= 0;
        end else begin
            case (state)
                0: begin
                    q <= a & b;
                    state <= a | b;
                end
                1: begin
                    q <= 0;
                    state <= 0;
                end
            endcase
        end
    end

endmodule
