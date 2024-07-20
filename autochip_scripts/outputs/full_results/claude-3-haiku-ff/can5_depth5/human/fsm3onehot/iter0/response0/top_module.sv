module top_module (
    input in,
    input [3:0] state,
    output reg [3:0] next_state,
    output out
);

always @(*) begin
    case (state)
        4'b0001: begin // State A
            if (in == 0) begin
                next_state = 4'b0001; // A
            end else begin
                next_state = 4'b0010; // B
            end
        end
        4'b0010: begin // State B
            if (in == 0) begin
                next_state = 4'b0100; // C
            end else begin
                next_state = 4'b0010; // B
            end
        end
        4'b0100: begin // State C
            if (in == 0) begin
                next_state = 4'b0001; // A
            end else begin
                next_state = 4'b1000; // D
            end
        end
        4'b1000: begin // State D
            if (in == 0) begin
                next_state = 4'b0100; // C
            end else begin
                next_state = 4'b0010; // B
            end
        end
        default: begin
            next_state = 4'b0001; // A
        end
    endcase
end

assign out = (state == 4'b1000) ? 1'b1 : 1'b0; // Output logic

endmodule
