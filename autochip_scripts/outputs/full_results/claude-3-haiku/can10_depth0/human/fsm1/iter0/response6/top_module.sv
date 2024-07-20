module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

// State definitions
parameter A = 1'b0;
parameter B = 1'b1;

// State register
reg state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= B;
        out <= 1'b1;
    end
    else begin
        case (state)
            B: begin
                if (in) begin
                    state <= B;
                    out <= 1'b1;
                end
                else begin
                    state <= A;
                    out <= 1'b0;
                end
            end
            A: begin
                if (in) begin
                    state <= A;
                    out <= 1'b0;
                end
                else begin
                    state <= B;
                    out <= 1'b1;
                end
            end
        endcase
    end
end

endmodule
