module top_module (
    input in,
    input [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

    always_comb begin
        case (state)
            2'b00: begin // State A
                if (in)
                    next_state = 2'b01; // Transition to State B
                else
                    next_state = 2'b00; // Remain in State A
            end
            2'b01: begin // State B
                if (in)
                    next_state = 2'b01; // Remain in State B
                else
                    next_state = 2'b10; // Transition to State C
            end
            2'b10: begin // State C
                if (in)
                    next_state = 2'b11; // Transition to State D
                else
                    next_state = 2'b00; // Transition to State A
            end
            2'b11: begin // State D
                if (in)
                    next_state = 2'b01; // Transition to State B
                else
                    next_state = 2'b10; // Transition to State C
            end
        endcase
    end

    always @(posedge clk or negedge rstn) begin
        if (~rstn) begin
            next_state <= 2'b00; // Reset to State A
            out <= 1'b0; // Reset out signal to low
        end else begin
            state <= next_state; // Update state
            if (state == 2'b11) // Check if current state is D
                out <= 1'b1; // Set out signal high
            else
                out <= 1'b0; // Set out signal low
        end
    end

endmodule
