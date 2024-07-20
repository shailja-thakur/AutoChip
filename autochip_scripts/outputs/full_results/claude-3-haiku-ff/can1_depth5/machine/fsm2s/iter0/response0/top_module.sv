module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

reg state;
parameter A = 1'b0, B = 1'b1;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= A;
    end
    else begin
        case (state)
            A: begin
                if (j) begin
                    state <= B;
                end
                else begin
                    state <= A;
                end
            end
            B: begin
                if (k) begin
                    state <= A;
                end
                else begin
                    state <= B;
                end
            end
            default: begin
                state <= A;
            end
        endcase
    end
end

always @(*) begin
    case (state)
        A: begin
            out = 1'b0;
        end
        B: begin
            out = 1'b1;
        end
        default: begin
            out = 1'b0;
        end
    endcase
end

endmodule
