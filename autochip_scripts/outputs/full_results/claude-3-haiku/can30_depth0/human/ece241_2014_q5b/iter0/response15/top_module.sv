module top_module (
    input clk,
    input areset,
    input x,
    output z
);

reg [1:0] state;
parameter A = 2'b01, B = 2'b10;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= A;
    end else begin
        case (state)
            A: begin
                if (x) begin
                    state <= B;
                    z <= 1;
                end else begin
                    state <= A;
                    z <= 0;
                end
            end
            B: begin
                if (x) begin
                    state <= B;
                    z <= 0;
                end else begin
                    state <= B;
                    z <= 1;
                end
            end
            default: begin
                state <= A;
                z <= 0;
            end
        endcase
    end
end

endmodule
