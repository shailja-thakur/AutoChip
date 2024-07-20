module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

// Define the state variables
reg state;
parameter A = 1'b0, B = 1'b1;

always @(posedge clk) begin
    if (reset) begin
        // Reset the state to B
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
            default: begin
                state <= B;
                out <= 1'b1;
            end
        endcase
    end
end

endmodule
