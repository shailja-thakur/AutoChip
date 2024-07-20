module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter A = 1'b0, B = 1'b1;
reg state;

always @(posedge clk or posedge areset) begin
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
                if (~x) begin
                    state <= A;
                end
                else begin
                    state <= B;
                end
            end
            default: state <= A;
        endcase
    end
end

always @(*) begin
    case (state)
        A: begin
            z = x;
        end
        B: begin
            z = ~x;
        end
        default: begin
            z = 0;
        end
    endcase
end

endmodule
