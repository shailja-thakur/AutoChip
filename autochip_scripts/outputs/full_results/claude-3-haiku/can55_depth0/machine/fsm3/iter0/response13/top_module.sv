module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

reg [1:0] state, next_state;

always @(*) begin
    case (state)
        2'b00: begin // State A
            if (in)
                next_state = 2'b01; // State B
            else
                next_state = 2'b00; // State A
        end
        2'b01: begin // State B
            if (in)
                next_state = 2'b01; // State B
            else
                next_state = 2'b10; // State C
        end
        2'b10: begin // State C
            if (in)
                next_state = 2'b11; // State D
            else
                next_state = 2'b00; // State A
        end
        2'b11: begin // State D
            if (in)
                next_state = 2'b01; // State B
            else
                next_state = 2'b10; // State C
        end
    endcase
end

always @(posedge clk or posedge areset) begin
    if (areset)
        state <= 2'b00; // Reset to State A
    else
        state <= next_state;
end

always @(*) begin
    out = (state == 2'b11); // Set output to 1 when in State D
end

endmodule
