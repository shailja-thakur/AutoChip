module top_module (
	input clk,
	input reset,
	input w,
	output z
);

// State enumeration
typedef enum logic [2:0] {
    A, B, C, D, E, F
} state_type;

// State signals
reg state_reg;
reg next_state_reg;

// Output signal
assign z = (state_reg == E || state_reg == F) ? 1'b1 : 1'b0;

// State machine logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state_reg <= A;
    end else begin
        state_reg <= next_state_reg;
    end
end

// Next state logic
always @(state_reg or w) begin
    case (state_reg)
        A: begin
            if (w == 1'b0) begin
                next_state_reg = B;
            end else begin
                next_state_reg = A;
            end
        end
        B: begin
            if (w == 1'b1) begin
                next_state_reg = D;
            end else begin
                next_state_reg = C;
            end
        end
        C: begin
            if (w == 1'b1) begin
                next_state_reg = D;
            end else begin
                next_state_reg = E;
            end
        end
        D: begin
            if (w == 1'b1) begin
                next_state_reg = A;
            end else begin
                next_state_reg = F;
            end
        end
        E: begin
            if (w == 1'b1) begin
                next_state_reg = D;
            end else begin
                next_state_reg = E;
            end
        end
        F: begin
            if (w == 1'b1) begin
                next_state_reg = D;
            end else begin
                next_state_reg = C;
            end
        end
        default: next_state_reg = A;
    endcase
end

endmodule
