module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    // Define states
    parameter A = 1'b0, B = 1'b1;
    reg state, next_state;

    // Sequential logic for state transition on clock edge or asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next_state;
    end

    // Combinational logic to determine next state
    always @(*) begin
        case (state)
            A: begin
                if (x == 1'b1)
                    next_state = B;
                else
                    next_state = A;
            end
            B: begin
                next_state = B;
            end
            default: begin
                next_state = A;
            end
        endcase
    end

    // Combinational logic to determine output
    always @(*) begin
        case (state)
            A: begin
                if (x == 1'b1)
                    z = 1'b1;
                else
                    z = 1'b0;
            end
            B: begin
                if (x == 1'b0)
                    z = 1'b1;
                else
                    z = 1'b0;
            end
            default: z = 1'b0;
        endcase
    end

endmodule
