module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [3:0] state, next_state;

always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= 'h0;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        'h0: // state A
            if (s) begin
                next_state = 'h1; // state B
            end else begin
                next_state = state;
            end
        'h1: // state B
            if (w) begin
                next_state = 'h3; // state S11
            end else begin
                next_state = 'h2; // state S10
            end
        'h2: // state S10
            if (w) begin
                next_state = 'h5; // state S21
            end else begin
                next_state = 'h4; // state S20
            end
        'h3: // state S11
            if (w) begin
                next_state = 'h6; // state S22
            end else begin
                next_state = 'h5; // state S21
            end
        'h4: // state S20
            next_state = 'h1; // state B
        'h5: // state S21
            if (w) begin
                next_state = 'h7; // state C
            end else begin
                next_state = 'h1; // state B
            end
        'h6: // state S22
            if (w) begin
                next_state = 'h1; // state B
            end else begin
                next_state = 'h7; // state C
            end
        'h7: // state C
            if (w) begin
                next_state = 'h3; // state S11
            end else begin
                next_state = 'h2; // state S10
            end
        default:
            next_state = 'h0;
    endcase
end

always @(posedge clk) begin
    if (state == 'h1 || state == 'h3 || state == 'h6) begin
        z <= 1'b1;
    end else begin
        z <= 1'b0;
    end
end

endmodule
