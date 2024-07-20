module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    // Define states
    typedef enum logic [1:0] {B, A} state_type;
    state_type current_state, next_state;

    // Declare outputs
    wire out_reg;

    // Register to store the current state
    reg state_type state_reg;

    // Define state transitions and outputs
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= B;
        end else begin
            current_state <= next_state;
        end
    end

    // State logic and output generation
    always_comb begin
        case (current_state)
            B: begin
                next_state = (in) ? B : A;
                out_reg = 1'b1;
            end
            A: begin
                next_state = (in) ? A : B;
                out_reg = 1'b0;
            end
        endcase
    end

    // Assign output
    assign out = out_reg;

endmodule
