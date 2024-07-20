module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [2:0] state, next_state;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= 3'b000; // state A
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        3'b000: // state A
            if (s) begin
                next_state = 3'b001; // state B
            end
            else begin
                next_state = 3'b000; // state A
            end
        3'b001: // state B
            if (w) begin
                next_state = 3'b010; // state S11
            end
            else begin
                next_state = 3'b011; // state S10
            end
        3'b010: // state S11
            if (w) begin
                next_state = 3'b100; // state S22
            end
            else begin
                next_state = 3'b011; // state S21
            end
        3'b011: // state S10
            if (w) begin
                next_state = 3'b101; // state S21
            end
            else begin
                next_state = 3'b110; // state S20
            end
        3'b100: // state S22
            if (w) begin
                next_state = 3'b001; // state B
            end
            else begin
                next_state = 3'b010; // state C
            end
        3'b101: // state S21
            if (w) begin
                next_state = 3'b010; // state C
            end
            else begin
                next_state = 3'b001; // state B
            end
        3'b110: // state S20
            next_state = 3'b001; // state B
        default:
            next_state = 3'b000; // state A
    endcase
end

always @(state) begin
    case (state)
        3'b000: z = 1'b0; // state A
        3'b001: z = 1'b0; // state B
        3'b010: z = 1'b1; // state S11
        3'b011: z = 1'b0; // state S10
        3'b100: z = 1'b1; // state S22
        3'b101: z = 1'b1; // state S21
        3'b110: z = 1'b0; // state S20
        default: z = 1'b0;
    endcase
end

endmodule
