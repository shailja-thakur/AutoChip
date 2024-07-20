module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

    // Define states
    typedef enum logic [1:0] {A, B} state_type;
    state_type current_state;
    state_type next_state;

    // Combinational always block for determining next state
    always_comb begin
        case(current_state)
            A: if (j) begin
                    next_state = B;
               end else begin
                    next_state = A;
               end
            B: if (k) begin
                    next_state = A;
               end else begin
                    next_state = B;
               end
        endcase
    end

    // Clocked always block for updating state based on areset and next state
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

    // Output current state
    assign out = (current_state == B) ? 1'b1 : 1'b0;

endmodule
