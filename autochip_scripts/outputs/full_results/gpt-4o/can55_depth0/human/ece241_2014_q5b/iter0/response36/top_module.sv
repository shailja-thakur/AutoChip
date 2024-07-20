module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // One-hot encoding states
    reg [1:0] state, next_state;
    parameter A = 2'b01, B = 2'b10;

    // State transition with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Next state and output logic
    always @(*) begin
        case (state)
            A: begin
                if (x == 1) begin
                    next_state = B;
                    z = 1;
                end else begin
                    next_state = A;
                    z = 0;
                end
            end
            B: begin
                if (x == 1) begin
                    next_state = B;
                    z = 0;
                end else begin
                    next_state = B;
                    z = 1;
                end
            end
            default: begin
                next_state = A;
                z = 0;
            end
        endcase
    end

endmodule
