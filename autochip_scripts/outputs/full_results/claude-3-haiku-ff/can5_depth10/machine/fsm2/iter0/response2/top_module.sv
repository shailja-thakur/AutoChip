module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg state, next_state;

// State definitions
parameter A = 1'b0;
parameter B = 1'b1;

// Combinational block to determine next state
always @(*) begin
    case (state)
        A: begin
            if (j) begin
                next_state = B;
            end else begin
                next_state = A;
            end
        end
        B: begin
            if (k) begin
                next_state = A;
            end else begin
                next_state = B;
            end
        end
        default: begin
            next_state = A;
        end
    endcase
end

// Clocked block to update state
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= A;
    end else begin
        state <= next_state;
    end
end

// Assign output based on current state
always @(*) begin
    if (state == B) begin
        out = 1'b1;
    end else begin
        out = 1'b0;
    end
end

endmodule
