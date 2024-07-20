module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // Define state variables
    reg [3:0] state, next_state;

    // Define state values
    parameter S = 4'b000;
    parameter S1 = 4'b001;
    parameter S10 = 4'b010;

    // Define state assignments
    always @(posedge clk or negedge aresetn) begin
        if (~aresetn) begin
            state <= S;
        end else begin
            state <= next_state;
        end
    end

    // Define state transitions
    always @(state, x) begin
        case (state)
            S: begin
                if (x == 1'b0) begin
                    next_state = S;
                end else begin
                    next_state = S1;
                end
            end

            S1: begin
                if (x == 1'b0) begin
                    next_state = S10;
                end else begin
                    next_state = S1;
                end
            end

            S10: begin
                if (x == 1'b0) begin
                    next_state = S;
                end else begin
                    next_state = S1;
                end
            end
        endcase
    end

    // Define output assignments
    always @(state, x) begin
        case (state)
            S, S1: begin
                z = 1'b0;
            end
            
            S10: begin
                 z = x;
            end
        endcase
    end

endmodule
