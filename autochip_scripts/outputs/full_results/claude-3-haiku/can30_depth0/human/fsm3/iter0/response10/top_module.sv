module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg [1:0] state, next_state;

always @(*) begin
    case (state)
        2'b00: begin // State A
            if (in == 0) begin
                next_state = 2'b00; // A
            end else begin
                next_state = 2'b01; // B
            end
            out = 0;
        end
        2'b01: begin // State B
            if (in == 0) begin
                next_state = 2'b10; // C
            end else begin
                next_state = 2'b01; // B
            end
            out = 0;
        end
        2'b10: begin // State C
            if (in == 0) begin
                next_state = 2'b00; // A
            end else begin
                next_state = 2'b11; // D
            end
            out = 0;
        end
        2'b11: begin // State D
            if (in == 0) begin
                next_state = 2'b10; // C
            end else begin
                next_state = 2'b01; // B
            end
            out = 1;
        end
    endcase
end

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= 2'b00; // State A
    end else begin
        state <= next_state;
    end
end

endmodule
