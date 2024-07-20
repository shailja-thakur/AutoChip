module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    typedef enum logic [1:0] {
        S,
        S1,
        S10
    } State;

    reg [1:0] current_state, next_state;

    always_ff @(posedge clk or negedge aresetn) begin
        if (!aresetn) begin
            current_state <= S;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        case (current_state)
            S: begin
                if (x == 1) begin
                    next_state = S1;
                end else begin
                    next_state = S;
                end
                z = 0;
            end
            S1: begin
                if (x == 1) begin
                    next_state = S1;
                end else begin
                    next_state = S10;
                end
                z = 0;
            end
            S10: begin
                if (x == 1) begin
                    next_state = S1;
                end else begin
                    next_state = S;
                end
                z = x;
            end
            default: begin
                next_state = S;
                z = 0;
            end
        endcase
    end

endmodule
