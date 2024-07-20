module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state;
parameter A = 2'b00, B = 2'b01;

always @(posedge clk, posedge areset) begin
    if (areset) begin
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
            default: begin
                state <= B;
            end
        endcase
    end
end

always @(*) begin
    case (state)
        A: out = 1'b0;
        B: out = 1'b1;
        default: out = 1'b0;
    endcase
end

endmodule
