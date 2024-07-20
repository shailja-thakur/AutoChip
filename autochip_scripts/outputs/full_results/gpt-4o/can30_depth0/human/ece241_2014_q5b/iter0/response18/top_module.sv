module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding using one-hot encoding
    reg [1:0] state, next_state;
    parameter A = 2'b01, B = 2'b10;

    // State transition on clock edge
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A; // Reset state A
        else
            state <= next_state;
    end

    // Next state logic and output logic
    always @(*) begin
        case (state)
            A: begin
                if (x == 0) begin
                    next_state = A;
                    z = 0;
                end else begin
                    next_state = B;
                    z = 1;
                end
            end
            B: begin
                if (x == 0) begin
                    next_state = B;
                    z = 1;
                end else begin
                    next_state = B;
                    z = 0;
                end
            end
            default: begin
                next_state = A;
                z = 0;
            end
        endcase
    end
endmodule
