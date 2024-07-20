module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

// Define states
typedef enum logic [1:0] {
    S,
    S1,
    S10
} state_type;

// Declare signals
reg [1:0] state, next_state;

// Transition logic
always_ff @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= S;
    end else begin
        state <= next_state;
    end
end

// State transition and output logic
always_comb begin
    case(state)
        S: begin
            if (x == 1'b0) begin
                next_state = S;
            end else begin
                next_state = S1;
            end
            z = 1'b0;
        end
        S1: begin
            if (x == 1'b0) begin
                next_state = S10;
            end else begin
                next_state = S1;
            end
            z = 1'b0;
        end
        S10: begin
            if (x == 1'b0) begin
                next_state = S;
            end else begin
                next_state = S1;
            end
            z = x;
        end
        default: begin
            next_state = S;
            z = 1'b0;
        end
    endcase
end

endmodule
