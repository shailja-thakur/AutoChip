module top_module (
    input clk,
    input in,
    input areset,
    output out
);

reg [1:0] state, next_state;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= 2'b01; // B
    end else begin
        state <= next_state;
    end
end

always @(state, in) begin
    case (state)
        2'b00: begin // A
            if (in) begin
                next_state = 2'b00; // A
            end else begin
                next_state = 2'b01; // B
            end
        end
        2'b01: begin // B
            if (in) begin
                next_state = 2'b01; // B
            end else begin
                next_state = 2'b00; // A
            end
        end
        default: begin
            next_state = 2'b01; // B
        end
    endcase
end

assign out = (state == 2'b01); // B

endmodule
