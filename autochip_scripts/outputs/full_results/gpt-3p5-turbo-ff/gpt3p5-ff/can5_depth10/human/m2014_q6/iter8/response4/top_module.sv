module top_module (
    input clk,
    input reset,
    input w,
    output z
);

    // Define the states
    typedef enum logic [2:0] {
        S_A,
        S_B,
        S_C,
        S_D,
        S_E,
        S_F
    } state_t;

    // Define the state register and next state variables
    reg state_t state_reg, state_next;

    // Define the output register
    reg z_reg;

    // State register
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state_reg <= S_A;
        end else begin
            state_reg <= state_next;
        end
    end

    // Next state logic
    always_comb begin
        case (state_reg)
            S_A: begin
                if (w) begin
                    state_next = S_A;
                end else begin
                    state_next = S_B;
                end
            end
            S_B: begin
                if (w) begin
                    state_next = S_D;
                end else begin
                    state_next = S_A;
                end
            end
            S_C: begin
                if (w) begin
                    state_next = S_D;
                end else begin
                    state_next = S_E;
                end
            end
            S_D: begin
                if (w) begin
                    state_next = S_A;
                end else begin
                    state_next = S_F;
                end
            end
            S_E: begin
                if (w) begin
                    state_next = S_D;
                end else begin
                    state_next = S_E;
                end
            end
            S_F: begin
                if (w) begin
                    state_next = S_D;
                end else begin
                    state_next = S_C;
                end
            end
            default: state_next = S_A;
        endcase
    end

    // Output logic
    always_comb begin
        case (state_reg)
            S_A, S_B, S_C, S_D: z_reg = 1'b0;
            S_E, S_F: z_reg = 1'b1;
            default: z_reg = 1'b0;
        endcase
    end

    // Assign output
    assign z = z_reg;
endmodule
