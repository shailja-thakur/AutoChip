module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

parameter A = 1'b0, B = 1'b1;
reg state;

always @(posedge clk, negedge areset) begin
    if (!areset) begin
        state <= B;
    end
    else begin
        case (state)
            B: begin
                if (in == 1'b0) begin
                    state <= A;
                end
                else begin
                    state <= B;
                end
            end
            A: begin
                if (in == 1'b0) begin
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
        A: out = 1'b0;
        B: out = 1'b1;
    endcase
end

endmodule
