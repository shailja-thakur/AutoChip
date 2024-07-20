module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

    // Declare state variables
    reg [3:0] state;
    reg [3:0] next_state;

    // Define states
    parameter S = 4'b001;
    parameter S1 = 4'b010;
    parameter S10 = 4'b100;

    // Sequential logic
    always @(posedge clk or negedge aresetn) begin
        if (~aresetn) begin
            state <= S;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(state or x) begin
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

            default: next_state = S;
        endcase
    end

    // Output logic
    always @(state or x) begin
        case (state)
            S, S1: z = 1'b0;
            S10: z = x;
            default: z = 1'b0;
        endcase
    end

endmodule
