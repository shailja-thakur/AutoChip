module top_module (
    input clk,
    input areset,
    input x,
    output z
);

reg [1:0] state;
parameter A = 2'b01, B = 2'b10;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
    end
    else begin
        case (state)
            A: begin
                if (x == 1'b0) begin
                    state <= A;
                end
                else begin
                    state <= B;
                end
            end
            B: begin
                if (x == 1'b0) begin
                    state <= B;
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

assign z = (state == B && x == 1'b0) || (state == A && x == 1'b1);

endmodule
