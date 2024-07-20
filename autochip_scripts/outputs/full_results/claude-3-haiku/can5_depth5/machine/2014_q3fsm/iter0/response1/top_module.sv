module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [3:0] state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 'h0;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    case (state)
        'h0: begin // state A
            if (s) begin
                next_state = 'h1; // state B
            end else begin
                next_state = 'h0;
            end
        end
        'h1: begin // state B
            if (w) begin
                next_state = 'h3; // state S11
            end else begin
                next_state = 'h2; // state S10
            end
        end
        'h2: begin // state S10
            if (w) begin
                next_state = 'h5; // state S21
            end else begin
                next_state = 'h4; // state S20
            end
        end
        'h3: begin // state S11
            if (w) begin
                next_state = 'h6; // state S22
            end else begin
                next_state = 'h5; // state S21
            end
        end
        'h4: begin // state S20
            next_state = 'h1; // state B
        end
        'h5: begin // state S21
            if (w) begin
                next_state = 'h1; // state C
            end else begin
                next_state = 'h1; // state B
            end
        end
        'h6: begin // state S22
            if (w) begin
                next_state = 'h1; // state B
            end else begin
                next_state = 'h1; // state C
            end
        end
        'h7: begin // state C
            if (w) begin
                next_state = 'h3; // state S11
            end else begin
                next_state = 'h2; // state S10
            end
        end
        default: begin
            next_state = 'h0;
        end
    endcase
end

always @(posedge clk) begin
    if (reset) begin
        z <= 1'b0;
    end else begin
        case (state)
            'h4: begin // state S20
                z <= 1'b1;
            end
            default: begin
                z <= 1'b0;
            end
        endcase
    end
end

endmodule
