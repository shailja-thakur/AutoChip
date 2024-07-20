module top_module (
    input clk,
    input areset,
    input x,
    output z
);

    // Declare the states as parameters
    parameter A = 1'b1;
    parameter B = 1'b0;

    // Declare the flip flops for storing the state
    reg state_q_next, state_q;

    // Declare the output flip flop
    reg z_q;

    // Assign the initial state
    always @(posedge clk, posedge areset) begin
        if (areset)
            state_q <= A;
        else
            state_q <= state_q_next;
    end

    // Define the state transition and output logic
    always @(state_q or x) begin
        case (state_q)
            A: begin
                if (x == 1'b0) begin
                    state_q_next = A;
                    z_q = 1'b0;
                end
                else begin
                    state_q_next = B;
                    z_q = 1'b1;
                end
            end

            B: begin
                if (x == 1'b0) begin
                    state_q_next = B;
                    z_q = 1'b1;
                end
                else begin
                    state_q_next = B;
                    z_q = 1'b0;
                end
            end
        endcase
    end

    // Assign the outputs
    assign z = z_q;

endmodule
