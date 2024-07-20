module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg state, next_state;

// State transition logic
always @(posedge clock) begin
    state <= next_state;
end

// Next state logic
always @(*) begin
    case (state)
        1'b0: begin
            if (a) begin
                next_state = 1'b1;
                p = 1'b0;
                q = 1'b0;
            end else begin
                next_state = 1'b0;
                p = 1'b0;
                q = 1'b0;
            end
        end
        1'b1: begin
            if (a) begin
                next_state = 1'b1;
                p = 1'b1;
                q = 1'b0;
            end else begin
                next_state = 1'b0;
                p = 1'b1;
                q = 1'b1;
            end
        end
        default: begin
            next_state = 1'b0;
            p = 1'b0;
            q = 1'b0;
        end
    endcase
end

endmodule
