module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [3:0] state, next_state;

parameter A = 0, B = 1, C = 2, S10 = 3, S11 = 4, S20 = 5, S21 = 6, S22 = 7;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

always @* begin
    case (state) 
        A: begin
            if (s) begin
                next_state = B;
            end else begin
                next_state = A;
            end
        end
        B: begin
            if (w) begin
                next_state = S11;
            end else begin
                next_state = S10;
            end
        end
        C: begin
            if (w) begin
                next_state = S11;
            end else begin
                next_state = S10;
            end
        end
        S10: begin
            if (w) begin
                next_state = S21;
            end else begin
                next_state = S20;
            end
        end
        S11: begin
            if (w) begin
                next_state = S22;
            end else begin
                next_state = S21;
            end
        end
        S20: begin
            next_state = B;
        end
        S21: begin
            if (w) begin
                next_state = C;
            end else begin
                next_state = B;
            end
        end
        S22: begin
            if (w) begin
                next_state = B;
            end else begin
                next_state = C;
            end
        end
    endcase
end

always @(posedge clk) begin
    if (reset) begin
        z <= 0;
    end else begin
        case (state)
            A: begin
                // Output for state A (modify as needed)
                z <= 0;
            end
            B: begin
                // Output for state B (modify as needed)
                z <= 0;
            end
            C: begin
                // Output for state C (modify as needed)
                z <= 0;
            end
            S10: begin
                // Output for state S10 (modify as needed)
                z <= 0;
            end
            S11: begin
                // Output for state S11 (modify as needed)
                z <= 0;
            end
            S20: begin
                // Output for state S20 (modify as needed)
                z <= 0;
            end
            S21: begin
                // Output for state S21 (modify as needed)
                z <= 0;
            end
            S22: begin
                // Output for state S22 (modify as needed)
                z <= 0;
            end
        endcase
    end
end

endmodule
