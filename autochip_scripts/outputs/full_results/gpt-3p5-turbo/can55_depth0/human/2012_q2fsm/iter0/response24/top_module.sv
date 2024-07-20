module top_module (
    input clk,
    input reset,
    input w,
    output z
);

    // Define the states
    typedef enum logic [2:0] {
        A, B, C, D, E, F
    } state_t;

    // Declare the state register and next state variable
    reg state_t current_state, next_state;
    
    // Declare the output register
    reg z;

    // State transition and output logic
    always @(posedge clk, posedge reset) begin
        if (reset) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

    always @* begin
        case (current_state)
            A: begin
                if (w) begin
                    next_state = B;
                    z = 0;
                end else begin
                    next_state = A;
                    z = 0;
                end
            end

            B: begin
                if (w) begin
                    next_state = C;
                    z = 0;
                end else begin
                    next_state = D;
                    z = 0;
                end
            end

            C: begin
                if (w) begin
                    next_state = E;
                    z = 1;
                end else begin
                    next_state = D;
                    z = 0;
                end
            end

            D: begin
                if (w) begin
                    next_state = F;
                    z = 0;
                end else begin
                    next_state = A;
                    z = 0;
                end
            end

            E: begin
                if (w) begin
                    next_state = E;
                    z = 1;
                end else begin
                    next_state = D;
                    z = 0;
                end
            end

            F: begin
                if (w) begin
                    next_state = C;
                    z = 1;
                end else begin
                    next_state = D;
                    z = 0;
                end
            end
        endcase
    end

endmodule
