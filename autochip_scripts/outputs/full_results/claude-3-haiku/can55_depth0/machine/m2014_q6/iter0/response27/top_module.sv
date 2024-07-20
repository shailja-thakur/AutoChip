module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

    // Define the states
    parameter A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3, E = 3'd4, F = 3'd5;

    // Register to store the current state
    reg [2:0] current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            A: begin
                if (w == 1'b0) next_state = B;
                else next_state = A;
            end
            B: begin
                if (w == 1'b1) next_state = D;
                else next_state = C;
            end
            C: begin
                if (w == 1'b1) next_state = D;
                else next_state = E;
            end
            D: begin
                if (w == 1'b1) next_state = A;
                else next_state = F;
            end
            E: begin
                if (w == 1'b1) next_state = D;
                else next_state = E;
            end
            F: begin
                if (w == 1'b1) next_state = D;
                else next_state = C;
            end
            default: next_state = A;
        endcase
    end

    // Output logic
    always @(*) begin
        case (current_state)
            E, F: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

    // State update logic
    always @(posedge clk) begin
        if (reset) current_state <= A;
        else current_state <= next_state;
    end

endmodule
