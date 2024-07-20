module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);
    // State encoding
    parameter A = 2'b01, B = 2'b10;
    reg [1:0] state, next_state;

    // State transition and output logic
    always @(*) begin
        case (state)
            A: begin
                if (x)
                    next_state = B;
                else
                    next_state = A;
                z = x;
            end
            B: begin
                if (x)
                    next_state = B;
                else
                    next_state = B;
                z = ~x;
            end
            default: begin
                next_state = A;
                z = 0;
            end
        endcase
    end

    // State register with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

endmodule
