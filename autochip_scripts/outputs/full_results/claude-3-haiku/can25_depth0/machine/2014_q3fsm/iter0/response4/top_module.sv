module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [4:0] state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 5'b00001; // state A
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        5'b00001: // state A
            if (s) begin
                next_state = 5'b00010; // state B
            end
            else begin
                next_state = state;
            end
        5'b00010: // state B
            if (w) begin
                next_state = 5'b00011; // state S11
            end
            else begin
                next_state = 5'b00100; // state S10
            end
        5'b00011: // state S11
            if (w) begin
                next_state = 5'b00101; // state S22
            end
            else begin
                next_state = 5'b00100; // state S21
            end
        5'b00100: // state S10
            if (w) begin
                next_state = 5'b01000; // state S21
            end
            else begin
                next_state = 5'b00111; // state S20
            end
        5'b00101: // state S22
            if (w) begin
                next_state = 5'b00010; // state B
            end
            else begin
                next_state = 5'b00011; // state C
            end
        5'b00111: // state S20
            next_state = 5'b00010; // state B
        5'b01000: // state S21
            if (w) begin
                next_state = 5'b00011; // state C
            end
            else begin
                next_state = 5'b00010; // state B
            end
        default:
            next_state = 5'b00001; // state A
    endcase
end

always @(posedge clk) begin
    if (state == 5'b00011) // state S11
        z <= 1'b1;
    else
        z <= 1'b0;
end

endmodule
