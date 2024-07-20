module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

// Define the states
parameter A = 1'b0;
parameter B = 1'b1;

// State register
reg state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        // Asynchronous reset
        state <= A;
        z <= 1'b0;
    end
    else begin
        // State transition logic
        case (state)
            A: begin
                if (x) begin
                    state <= B;
                    z <= 1'b1;
                end
                else begin
                    state <= A;
                    z <= 1'b0;
                end
            end
            B: begin
                if (~x) begin
                    state <= B;
                    z <= 1'b1;
                end
                else begin
                    state <= A;
                    z <= 1'b0;
                end
            end
            default: begin
                state <= A;
                z <= 1'b0;
            end
        endcase
    end
end

endmodule
