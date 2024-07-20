module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg [1:0] state, next_state;
// Initializing the state to B
initial state = 2'b10;

always @ (posedge clk or posedge areset) begin
    if (areset) begin
        // Asynchronously reset to state B
        state <= 2'b10;
    end
    else begin
        // State transition logic
        case (state)
            2'b00: begin
                if (in) begin
                    next_state <= 2'b01;
                end
                else begin
                    next_state <= 2'b10;
                end
            end
            2'b01: begin
                if (in) begin
                    next_state <= 2'b11;
                end
                else begin
                    next_state <= 2'b00;
                end
            end
            2'b10: begin
                if (in) begin
                    next_state <= 2'b10;
                end
                else begin
                    next_state <= 2'b01;
                end
            end
            2'b11: begin
                if (in) begin
                    next_state <= 2'b11;
                end
                else begin
                    next_state <= 2'b00;
                end
            end
            default: next_state <= 2'b10;
        endcase
    end
end

always @ (posedge clk or posedge areset) begin
    if (areset) begin
        // Asynchronously reset output to 1'b0
        out <= 1'b0;
    end
    else begin
        // Output logic
        case (state)
            2'b01, 2'b11: out <= 1'b1;
            default: out <= 1'b0;
        endcase
    end
end

always @ (posedge clk) begin
    if (areset) begin
        // Asynchronously reset state to B
        state <= 2'b10;
    end
    else begin
        // Update state
        state <= next_state;
    end
end

endmodule
