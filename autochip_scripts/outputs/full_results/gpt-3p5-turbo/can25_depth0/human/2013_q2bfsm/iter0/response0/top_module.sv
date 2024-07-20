module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);

reg [1:0] state;

always @(posedge clk or negedge resetn) begin
    if (~resetn) begin
        state <= 2'b00; // State A
    end else begin
        case (state)
            2'b00: begin // State A
                if (resetn) begin
                    state <= 2'b01; // Transition to State B
                end
            end
            2'b01: begin // State B
                state <= 2'b10; // Transition to State C
                f <= 1'b1; // Set output f to 1 for one clock cycle
            end
            2'b10: begin // State C
                if (x == 1'b1) begin
                    state <= 2'b11; // Transition to State D
                end
            end
            2'b11: begin // State D
                if (x == 1'b0) begin
                    state <= 2'b10; // Transition back to State C
                end
            end
            default: begin // All other states
                state <= 2'b00; // Transition back to State A
            end
        endcase
    end
end

always @(posedge clk) begin
    case (state)
        2'b00: begin // State A
            f <= 1'b0;
            g <= 1'b0;
        end
        2'b01: begin // State B
            f <= 1'b1;
            g <= 1'b0;
        end
        2'b10: begin // State C
            f <= 1'b0;
            g <= 1'b0;
        end
        2'b11: begin // State D
            f <= 1'b0;
            if (y == 1'b1) begin
                g <= 1'b1;
            end else begin
                g <= 1'b0;
            end
        end
        default: begin // All other states
            f <= 1'b0;
            g <= 1'b0;
        end
    endcase
end

endmodule
