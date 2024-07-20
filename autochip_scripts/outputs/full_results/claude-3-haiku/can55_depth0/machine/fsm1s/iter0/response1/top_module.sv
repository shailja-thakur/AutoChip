module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

parameter A = 1'b0, B = 1'b1;
reg state;

always @(posedge clk) begin
    if (reset) begin
        state <= B;
    end
    else begin
        case (state)
            A: begin
                if (in) begin
                    state <= A;
                end
                else begin
                    state <= B;
                end
            end
            B: begin
                if (in) begin
                    state <= B;
                end
                else begin
                    state <= A;
                end
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
    endcase
end

endmodule
