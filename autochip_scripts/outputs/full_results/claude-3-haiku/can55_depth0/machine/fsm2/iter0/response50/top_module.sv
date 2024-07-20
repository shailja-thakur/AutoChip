module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output reg out
);

reg current_state, next_state;
parameter A = 1'b0, B = 1'b1;

// Combinational logic to determine the next state
always @(*) begin
    case (current_state)
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
        default: next_state = A;
    endcase
end

// Sequential logic to update the state
always @(posedge clk or posedge areset) begin
    if (areset) begin
        current_state <= A;
    end else begin
        current_state <= next_state;
    end
end

// Output logic
assign out = (current_state == B) ? 1'b1 : 1'b0;

endmodule
