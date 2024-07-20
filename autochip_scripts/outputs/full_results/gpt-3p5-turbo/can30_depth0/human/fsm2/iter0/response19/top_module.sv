module top_module (
    input wire clk,
    input wire j,
    input wire k,
    input wire areset,
    output wire out
);

reg [1:0] state;
wire next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b0;
    end else begin
        state <= next_state;
    end
end

always @(state or j or k) begin
    case(state)
        2'b00: begin // OFF
            if (j) begin
                next_state = 2'b01; // Transition to ON state
            end else begin
                next_state = 2'b00; // Remain in OFF state
            end
            out = 1'b0; // Output is 0 in OFF state
        end
        2'b01: begin // ON
            if (k) begin
                next_state = 2'b00; // Transition to OFF state
            end else begin
                next_state = 2'b01; // Remain in ON state
            end
            out = 1'b1; // Output is 1 in ON state
        end
        default: begin
            next_state = 2'b00; // Default state is OFF
            out = 1'b0; // Default output is 0
        end
    endcase
end

endmodule
