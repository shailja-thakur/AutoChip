module top_module (
    input clk,
    input in,
    input areset,
    output out
);

    // Define the states
    typedef enum logic [1:0] {
        B,
        A
    } state_t;

    // Define the state register
    reg state_t current_state, next_state;

    // Define the output register
    reg out_reg;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            // Asynchronously reset to state B
            current_state <= B;
        end else begin
            // Next state logic
            case (current_state)
                B: begin
                    if (in)
                        next_state <= B;
                    else
                        next_state <= A;
                end
                A: begin
                    if (in)
                        next_state <= A;
                    else
                        next_state <= B;
                end
                default: next_state <= B;
            endcase
        end
    end

    always_comb begin
        case (current_state)
            B: out_reg = 1'b1;
            A: out_reg = 1'b0;
            default: out_reg = 1'b1;
        endcase
    end

    assign out = out_reg;

    always_ff @(posedge clk or posedge areset) begin
        if (areset)
            current_state <= B;
        else
            current_state <= next_state;
    end

endmodule
