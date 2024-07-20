module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

parameter A = 0, B = 1;
reg state;

always @(posedge clk) begin
    if (reset) begin
        state <= B; // Reset to initial state B
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
        endcase
    end
end

always @* begin
    if (state == B) begin
        out = 1'b1;
    end
    else begin
        out = 1'b0;
    end
end

endmodule
