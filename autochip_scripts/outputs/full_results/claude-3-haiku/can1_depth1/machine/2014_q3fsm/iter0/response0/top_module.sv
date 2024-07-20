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
        state <= 'b0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        'b000: // state A
            if (s) begin
                next_state = 'b001; // state B
            end
            else begin
                next_state = state;
            end
        'b001: // state B
            if (w) begin
                next_state = 'b011; // state S11
            end
            else begin
                next_state = 'b010; // state S10
            end
        'b010: // state S10
            if (w) begin
                next_state = 'b101; // state S21
            end
            else begin
                next_state = 'b100; // state S20
            end
        'b011: // state S11
            if (w) begin
                next_state = 'b110; // state S22
            end
            else begin
                next_state = 'b101; // state S21
            end
        'b100: // state S20
            next_state = 'b001; // state B
        'b101: // state S21
            if (w) begin
                next_state = 'b010; // state C
            end
            else begin
                next_state = 'b001; // state B
            end
        'b110: // state S22
            if (w) begin
                next_state = 'b001; // state B
            end
            else begin
                next_state = 'b010; // state C
            end
        default:
            next_state = state;
    endcase
end

always @(posedge clk, posedge reset) begin
    if (reset) begin
        z <= 1'b0;
    end
    else begin
        case (state)
            'b001: // state B
            'b011: // state S11
            'b110: // state S22
                z <= 1'b1;
            default:
                z <= 1'b0;
        endcase
    end
end

endmodule
