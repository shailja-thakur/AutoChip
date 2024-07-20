module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // Define the states
    typedef enum {S, S1, S10} state_t;
    reg [1:0] current_state;
    reg [1:0] next_state;

    always @(posedge clk or negedge aresetn) begin
        if (~aresetn) begin
            current_state <= S;
        end else begin
            current_state <= next_state;
        end
    end

    always @(current_state or x) begin
        case (current_state)

            S: begin
                if (x == 0) begin
                    next_state = S;
                end else if (x == 1) begin
                    next_state = S1;
                end
            end

            S1: begin
                if (x == 0) begin
                    next_state = S10;
                end else if (x == 1) begin
                    next_state = S1;
                end
            end

            S10: begin
                if (x == 0) begin
                    next_state = S;
                end else if (x == 1) begin
                    next_state = S1;
                end
            end

        endcase
    end

    always @(current_state) begin
        case (current_state)

            S, S1: begin
                z <= 0;
            end

            S10: begin
                z <= x;
            end

        endcase
    end

endmodule
