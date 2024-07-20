module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [3:0] state, next_state;

always @(*) begin
    case (state)
        4'd0: begin // state A
            if (s) begin
                next_state = 4'd1; // state B
            end else begin
                next_state = state; // stay in state A
            end
        end
        4'd1: begin // state B
            if (w) begin
                next_state = 4'd5; // state S11
            end else begin
                next_state = 4'd4; // state S10
            end
        end
        4'd2: begin // state C
            if (w) begin
                next_state = 4'd5; // state S11
            end else begin
                next_state = 4'd4; // state S10
            end
        end
        4'd3: begin // state S10
            if (w) begin
                next_state = 4'd7; // state S21
            end else begin
                next_state = 4'd6; // state S20
            end
        end
        4'd4: begin // state S11
            if (w) begin
                next_state = 4'd8; // state S22
            end else begin
                next_state = 4'd7; // state S21
            end
        end
        4'd5: begin // state S20
            next_state = 4'd1; // state B
        end
        4'd6: begin // state S21
            if (w) begin
                next_state = 4'd2; // state C
            end else begin
                next_state = 4'd1; // state B
            end
        end
        4'd7: begin // state S22
            if (w) begin
                next_state = 4'd1; // state B
            end else begin
                next_state = 4'd2; // state C
            end
        end
        default: begin
            next_state = 4'd0; // default to state A
        end
    endcase
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 4'd0; // reset to state A
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        4'd0: z = 1'b0; // state A
        4'd1, 4'd2, 4'd5, 4'd6, 4'd7: z = 1'b1; // states B, C, S20, S21, S22
        default: z = 1'b0; // default to 0
    endcase
end

endmodule
