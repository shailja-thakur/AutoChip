module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

localparam A = 1'b0, B = 1'b1;
reg state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= B;
        out <= 1'b1;
    end
    else begin
        case (state)
            A: begin
                if (in == 1'b0) begin
                    state <= B;
                    out <= 1'b1;
                end
                else begin
                    state <= A;
                    out <= 1'b0;
                end
            end
            B: begin
                if (in == 1'b0) begin
                    state <= B;
                    out <= 1'b1;
                end
                else begin
                    state <= A;
                    out <= 1'b0;
                end
            end
        endcase
    end
end

endmodule
