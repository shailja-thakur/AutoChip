module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // Define the states
    typedef enum logic [3:0] {
        S,
        S1,
        S10
    } state_t;

    // Define the state registers
    reg [3:0] state;
    reg [3:0] state_next;

    // Define the state transition and output assignments
    always @(posedge clk or negedge aresetn) begin
        if (~aresetn) begin
            state <= S;
        end else begin
            state <= state_next;
        end
    end

    // Define the next state logic
    always @* begin
        case (state)
            S: begin
                if (x == 0) begin
                    state_next = S;
                end else begin
                    state_next = S1;
                end
            end
            S1: begin
                if (x == 0) begin
                    state_next = S10;
                end else begin
                    state_next = S1;
                end
            end
            S10: begin
                if (x == 0) begin
                    state_next = S;
                end else begin
                    state_next = S1;
                end
            end
            default: begin
                state_next = S;
            end
        endcase
    end

    // Define the output logic
    always @* begin
        case (state)
            S, S1: begin
                z = 0;
            end
            S10: begin
                z = x;
            end
            default: begin
                z = 0;
            end
        endcase
    end

endmodule
