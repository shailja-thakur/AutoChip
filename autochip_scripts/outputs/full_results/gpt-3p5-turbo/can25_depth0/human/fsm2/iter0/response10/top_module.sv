module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

reg state, next_state, reset;

// Output logic
always @ (posedge clk, posedge areset) begin
    if (areset) begin
        state <= 0;
    end else begin
        state <= next_state;
    end
end

always @(state, j, k) begin
    case (state)
        0: begin // OFF
            if (j) begin // Transition to ON state
                next_state <= 1;
            end else begin // Stay in OFF state
                next_state <= 0;
            end
            out <= 0;
        end
        
        1: begin // ON
            if (k) begin // Transition to OFF state
                next_state <= 0;
            end else begin // Stay in ON state
                next_state <= 1;
            end
            out <= 1;
        end
        
        default: begin
            next_state <= 0;
            out <= 0;
        end
    endcase
end

endmodule
