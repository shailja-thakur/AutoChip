module top_module (
    input wire clk,
    input wire reset,
    input wire s,
    input wire w,
    output reg z
);

    typedef enum logic [4:0] {
        A, B, C, S10, S11, S20, S21, S22
    } state_type;

    reg [4:0] state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    always @* begin
        case (state)
            A: begin
                if (s) begin
                    next_state = B;
                end else begin
                    next_state = state;
                end
            end
            B: begin
                if (w) begin
                    next_state = S11;
                end else begin
                    next_state = S10;
                end
            end
            C: begin
                if (w) begin
                    next_state = S11;
                end else begin
                    next_state = S10;
                end
            end
            S10: begin
                if (w) begin
                    next_state = S21;
                end else begin
                    next_state = S20;
                end
            end
            S11: begin
                if (w) begin
                    next_state = S22;
                end else begin
                    next_state = S21;
                end
            end
            S20: begin
                next_state = B;
            end
            S21: begin
                if (w) begin
                    next_state = C;
                end else begin
                    next_state = B;
                end
            end
            S22: begin
                if (w) begin
                    next_state = B;
                end else begin
                    next_state = C;
                end
            end
            default: begin
                next_state = state;
            end
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            z <= 0;
        end else begin
            case (state)
                A: begin
                    z <= 0;
                end
                B: begin
                    z <= 0;
                end
                C: begin
                    z <= 0;
                end
                S10: begin
                    z <= 0;
                end
                S11: begin
                    z <= 0;
                end
                S20: begin
                    z <= 0;
                end
                S21: begin
                    z <= 0;
                end
                S22: begin
                    z <= 1;
                end
                default: begin
                    z <= 0;
                end
            endcase
        end
    end

endmodule
