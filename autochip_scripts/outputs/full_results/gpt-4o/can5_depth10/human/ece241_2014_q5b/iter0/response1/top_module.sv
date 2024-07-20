module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // State encoding using one-hot method
    reg [1:0] state, next_state;
    parameter A = 2'b01, B = 2'b10;

    // State transition logic
    always @(*) begin
        case (state)
            A: if (x) begin
                    next_state = B;
                    z = 1;
               end else begin
                    next_state = A;
                    z = 0;
               end
            B: if (x) begin
                    next_state = B;
                    z = 0;
               end else begin
                    next_state = B;
                    z = 1;
               end
        endcase
    end

    // State register with asynchronous active-high reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

endmodule
