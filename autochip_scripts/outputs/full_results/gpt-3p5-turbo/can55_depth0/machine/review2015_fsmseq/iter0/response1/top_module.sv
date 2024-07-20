module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    // State enumeration
    typedef enum logic [2:0] {
        S,
        S1,
        S11,
        S110,
        Done
    } State;

    // Registers
    reg[2:0] state_reg;
    reg[2:0] next_state_reg;

    // Combinational logic
    always_comb begin
        next_state_reg = state_reg;

        case (state_reg)
            S: begin
                if (data)
                    next_state_reg = S1;
                else
                    next_state_reg = S;

                start_shifting = 1'b0;
            end
            
            S1: begin
                if (data)
                    next_state_reg = S11;
                else
                    next_state_reg = S;

                start_shifting = 1'b0;
            end
            
            S11: begin
                if (data)
                    next_state_reg = S11;
                else
                    next_state_reg = S110;

                start_shifting = 1'b0;
            end

            S110: begin
                if (data)
                    next_state_reg = Done;
                else
                    next_state_reg = S;

                start_shifting = 1'b0;
            end

            Done: begin
                next_state_reg = Done;

                start_shifting = 1'b1;
            end
        endcase
    end

    // State machine update on clock edge
    always_ff @(posedge clk) begin
        if (reset)
            state_reg <= S;
        else
            state_reg <= next_state_reg;
    end

endmodule
