module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

reg [1:0] state;
parameter A = 2'b00;
parameter B = 2'b01;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
    end else begin
        case(state)
            A: begin
                if (x) begin
                    state <= B;
                end else begin
                    state <= A;
                end
            end
            B: begin
                if (!x) begin
                    state <= B;
                end else begin
                    state <= B;
                end
            end
            default: begin
                state <= A;
            end
        endcase
    end
end

always @(state) begin
    case(state)
        A: begin
            z = 1'b0;
        end
        B: begin
            z = 1'b1;
        end
        default: begin
            z = 1'b0;
        end
    endcase
end

endmodule
