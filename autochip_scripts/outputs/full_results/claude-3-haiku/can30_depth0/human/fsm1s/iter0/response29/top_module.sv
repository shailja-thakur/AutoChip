module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

reg current_state, next_state;
parameter A = 1'b0, B = 1'b1;

// State transitions
always @(current_state, in) begin
    case (current_state)
        A: begin
            if (in == 1'b0) begin
                next_state = B;
            end else begin
                next_state = A;
            end
        end
        B: begin
            if (in == 1'b0) begin
                next_state = B;
            end else begin
                next_state = B;
            end
        end
        default: begin
            next_state = B;
        end
    endcase
end

// Output logic
always @(current_state) begin
    case (current_state)
        A: begin
            out = 1'b0;
        end
        B: begin
            out = 1'b1;
        end
        default: begin
            out = 1'b0;
        end
    endcase
end

// State register
always @(posedge clk) begin
    if (reset) begin
        current_state <= B;
    end else begin
        current_state <= next_state;
    end
end

endmodule
