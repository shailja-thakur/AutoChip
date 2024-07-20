module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= 2'b00; // Reset to state A
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        2'b00: begin // State A
            out = 1'b0;
            if (in == 1'b0) begin
                next_state = 2'b00; // A -> A
            end else begin
                next_state = 2'b01; // A -> B
            end
        end
        2'b01: begin // State B
            out = 1'b0;
            if (in == 1'b0) begin
                next_state = 2'b10; // B -> C
            end else begin
                next_state = 2'b01; // B -> B
            end
        end
        2'b10: begin // State C
            out = 1'b0;
            if (in == 1'b0) begin
                next_state = 2'b00; // C -> A
            end else begin
                next_state = 2'b11; // C -> D
            end
        end
        2'b11: begin // State D
            out = 1'b1;
            if (in == 1'b0) begin
                next_state = 2'b10; // D -> C
            end else begin
                next_state = 2'b01; // D -> B
            end
        end
        default: begin
            out = 1'b0;
            next_state = 2'b00; // Reset to state A
        end
    endcase
end

endmodule
