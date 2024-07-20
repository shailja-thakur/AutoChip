module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

// State definitions
parameter A = 1'b0, B = 1'b1;

// State register
reg state;

always @(posedge clk) begin
    if (reset) begin
        // Reset state
        state <= B;
    end
    else begin
        case (state)
            B: begin
                out <= 1'b1;
                if (in) begin
                    state <= B;
                end
                else begin
                    state <= A;
                end
            end
            A: begin
                out <= 1'b0;
                if (in) begin
                    state <= A;
                end
                else begin
                    state <= B;
                end
            end
        endcase
    end
end

endmodule
