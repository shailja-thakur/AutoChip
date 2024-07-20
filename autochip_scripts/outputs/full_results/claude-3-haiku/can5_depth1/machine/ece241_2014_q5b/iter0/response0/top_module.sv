module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

parameter A = 0, B = 1;
reg [0:0] state;

always @(posedge clk, posedge areset) begin
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
                if (!x) begin
                    state <= B;
                end
                else begin
                    state <= A;
                end
            end
            default: begin
                state <= A;
            end
        endcase
    end
end

always @(*) begin
    if ((state == A && x) || (state == B && !x)) begin
        z = 1;
    end
    else begin
        z = 0;
    end
end

endmodule
