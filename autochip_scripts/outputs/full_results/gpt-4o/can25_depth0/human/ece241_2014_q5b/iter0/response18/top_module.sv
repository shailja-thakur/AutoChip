module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding
    parameter A = 2'b01;
    parameter B = 2'b10;

    reg [1:0] state, next_state;

    // State transition logic
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            A: begin
                if (x == 1'b0) begin
                    next_state = A;
                    z = 0;
                end else begin
                    next_state = B;
                    z = 1;
                end
            end
            B: begin
                if (x == 1'b0) begin
                    next_state = B;
                    z = 1;
                end else begin
                    next_state = B;
                    z = 0;
                end
            end
            default: begin
                next_state = A; // Default state to prevent latches
                z = 0;
            end
        endcase
    end

endmodule
