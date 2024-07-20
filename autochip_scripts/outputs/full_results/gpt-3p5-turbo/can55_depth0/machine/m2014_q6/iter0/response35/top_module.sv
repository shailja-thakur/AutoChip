module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

// state declaration
enum {A, B, C, D, E, F} state, next_state;

// state transition logic
always @(posedge clk) begin
    if (reset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

// next state logic
always @(state or w) begin
    case (state)
        A: begin
            if (w) begin
                next_state = A;
            end else begin
                next_state = B;
            end
        end
        B: begin
            if (w) begin
                next_state = D;
            end else begin
                next_state = C;
            end
        end
        C: begin
            if (w) begin
                next_state = D;
            end else begin
                next_state = E;
            end
        end
        D: begin
            if (w) begin
                next_state = A;
            end else begin
                next_state = F;
            end
        end
        E: begin
            if (w) begin
                next_state = D;
            end else begin
                next_state = E;
            end
        end
        F: begin
            if (w) begin
                next_state = D;
            end else begin
                next_state = C;
            end
        end
        default: next_state = A;
    endcase
end

// output logic
always @(state) begin
    if (state == E || state == F) begin
        z = 1'b1;
    end else begin
        z = 1'b0;
    end
end

endmodule
