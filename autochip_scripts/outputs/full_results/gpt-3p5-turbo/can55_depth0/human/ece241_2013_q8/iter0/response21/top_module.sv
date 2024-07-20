module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

// State declaration
typedef enum logic [1:0] {
    S0,
    S1,
    S2
} state_t;

// State variable
reg state;

always @(posedge clk or negedge aresetn) begin
    if (~aresetn) begin
        state <= S0;
    end else begin
        case (state)
            S0: begin
                if (x == 1'b1) begin
                    state <= S1;
                end else begin
                    state <= S0;
                end
            end
            S1: begin
                if (x == 1'b0) begin
                    state <= S2;
                end else begin
                    state <= S1;
                end
            end
            S2: begin
                if (x == 1'b1) begin
                    state <= S1;
                    z <= 1'b1; // Sequence "101" detected
                end else begin
                    state <= S0;
                end
            end
            default: state <= S0;
        endcase
    end
end

endmodule
