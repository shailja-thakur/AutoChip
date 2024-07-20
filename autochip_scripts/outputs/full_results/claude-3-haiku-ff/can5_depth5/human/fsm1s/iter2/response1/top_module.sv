module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg state;
parameter A = 1'b0, B = 1'b1;

always @(posedge clk) begin
    if (reset) begin
        state <= B;
    end
    else begin
        case (state)
            B: begin
                if (in) begin
                    state <= B;
                end
                else begin
                    state <= A;
                end
            end
            A: begin
                if (in) begin
                    state <= A;
                end
                else begin
                    state <= B;
                end
            end
        endcase
    end
end

always @(state) begin
    case (state)
        B: out <= 1'b1;
        A: out <= 1'b0;
    endcase
end

endmodule
