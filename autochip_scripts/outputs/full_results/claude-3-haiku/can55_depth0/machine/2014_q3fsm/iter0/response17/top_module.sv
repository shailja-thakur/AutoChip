module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [3:0] state, next_state;

always @(posedge clk, negedge reset) begin
    if (!reset) begin
        state <= 'b0;
    end
    else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        4'b0000: // state A
            if (s) begin
                next_state = 4'b0001; // state B
            end
            else begin
                next_state = state;
            end
        4'b0001: // state B
            if (w) begin
                next_state = 4'b1001; // state S11
            end
            else begin
                next_state = 4'b1000; // state S10
            end
        4'b0010: // state C
            if (w) begin
                next_state = 4'b1001; // state S11
            end
            else begin
                next_state = 4'b1000; // state S10
            end
        4'b1000: // state S10
            if (w) begin
                next_state = 4'b1101; // state S21
            end
            else begin
                next_state = 4'b1100; // state S20
            end
        4'b1001: // state S11
            if (w) begin
                next_state = 4'b1110; // state S22
            end
            else begin
                next_state = 4'b1101; // state S21
            end
        4'b1100: // state S20
            next_state = 4'b0001; // state B
        4'b1101: // state S21
            if (w) begin
                next_state = 4'b0010; // state C
            end
            else begin
                next_state = 4'b0001; // state B
            end
        4'b1110: // state S22
            if (w) begin
                next_state = 4'b0001; // state B
            end
            else begin
                next_state = 4'b0010; // state C
            end
        default:
            next_state = state;
    endcase
end

always @(posedge clk) begin
    case (state)
        4'b0000: // state A
            z <= 1'b0;
        4'b0001: // state B
            z <= 1'b0;
        4'b0010: // state C
            z <= 1'b0;
        4'b1000: // state S10
            z <= 1'b0;
        4'b1001: // state S11
            z <= 1'b0;
        4'b1100: // state S20
            z <= 1'b0;
        4'b1101: // state S21
            z <= 1'b0;
        4'b1110: // state S22
            z <= 1'b0;
        default:
            z <= 1'b0;
    endcase
end

endmodule
