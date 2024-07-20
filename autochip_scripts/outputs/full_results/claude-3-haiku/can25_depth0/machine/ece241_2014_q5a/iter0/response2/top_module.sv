module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter A = 2'b00, B = 2'b01, C = 2'b11;
reg [1:0] state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
    end
    else begin
        case (state)
            A: begin
                if (x)
                    state <= C;
                else
                    state <= A;
            end
            B: begin
                if (x)
                    state <= B;
                else
                    state <= C;
            end
            C: begin
                if (x)
                    state <= B;
                else
                    state <= C;
            end
            default: state <= A;
        endcase
    end
end

always @(*) begin
    case (state)
        C: z = 1'b1;
        default: z = 1'b0;
    endcase
end

endmodule
